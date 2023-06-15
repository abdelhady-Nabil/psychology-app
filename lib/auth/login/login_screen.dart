import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/layout/layout_screen.dart';

import '../../admin/admin_login.dart';
import '../../doctor/login_doctor.dart';
import '../../shared/cache_helper.dart';
import '../../widget/constant.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController  EmailTextController = TextEditingController();
  final TextEditingController  passwordController = TextEditingController();


   @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: BlocProvider(
        create: (BuildContext context)=>LoginCubit(),
        child: BlocConsumer<LoginCubit,LoginState>(
          listener: (context,state ){
            //var model = PsychologyCubit.get(context).model;
            if(state is LoginSuccessState){
              //PsychologyCubit.get(context).model;
              PsychologyCubit.get(context).getUserData();
              CacheHelper.saveData(
                  key: 'userId',
                  value: state.uid
              ).then((value)async{
                uid =state.uid;
                print('hereeeeeee');
                print(uid);
                PsychologyCubit.get(context).getUserData();

                await FirebaseFirestore.instance.collection('users').doc(uid).snapshots().forEach((element) {
                  if(element.data()?['emil'] == EmailTextController.text && element.data()?['password']==passwordController.text){
                    print('i user');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
                  }else{
                    showModalBottomSheet(context: context, builder: (context){
                      return Container(
                        height: 300,
                        color: Colors.red,
                        child: Center(
                          child: Column(
                            children: [
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                              }, child:Column(
                                children: [
                                  Text('Email or Password isnot correct',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                                  Text('back to login',style: TextStyle(color: Colors.black),),
                                ],
                              )),
                            ],
                          ),
                        ),
                      );
                    }
                    );
                  }
                });

              }).catchError((error){});
            }
            if(state is LoginErrorState){
             showModalBottomSheet(context: context, builder: (context){
               return Container(
                 height: 300,
                 color: Colors.red,
                 child: Center(
                   child: Column(
                     children: [
                       TextButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                       }, child:Column(
                         children: [
                           Text('Email or Password isnot correct',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                           Text('back to login',style: TextStyle(color: Colors.black),),
                         ],
                       )),
                     ],
                   ),
                 ),
               );
             }
             );
            }
          },
          builder: (context,state){
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: ModalProgressHUD(
                inAsyncCall: LoginCubit.get(context).showSpinner,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        const Text('Login',style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              label:Text('Enter your Email',style: TextStyle(color: PrimaryColor),),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email,color: PrimaryColor,)

                          ),
                          cursorColor: PrimaryColor,
                          controller:EmailTextController ,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter your Email";
                            }
                            final bool isValid = EmailValidator.validate(value);
                            if(!isValid){
                              return "Invalid Email Address";
                            }
                            return null;
                          },
                          onChanged: (value){
                            value = EmailTextController.text;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            label:Text('Enter your Password',style: TextStyle(color: PrimaryColor),),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: PrimaryColor)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: PrimaryColor)
                            ),
                            // border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock,color: PrimaryColor,),
                            suffixIcon: Icon(Icons.remove_red_eye,color: PrimaryColor,),

                          ),
                          cursorColor: PrimaryColor,
                          controller:passwordController ,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter your Email";
                            }
                          },

                          onChanged: (value){
                            value = passwordController.text;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: const Text('Forget password?',style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,

                          ),),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height:50,
                          color: PrimaryColor,
                          child: TextButton(
                            onPressed: ()async{
                              LoginCubit.get(context).playSpinner();

                              if(_formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(
                                    email: EmailTextController.text,
                                    password: passwordController.text
                                );
                              }
                              LoginCubit.get(context).showSpinner;
                              // if(_formKey.currentState!.validate()){
                              //   setState((){
                              //     showSpinner=true;
                              //   });
                              //   try{
                              //     final user = await _services.auth.signInWithEmailAndPassword(
                              //         email: _EmailTextController.text,
                              //         password: _passwordController.text
                              //     );
                              //     if(user!=null){
                              //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
                              //       setState((){
                              //         showSpinner=false;
                              //       });
                              //     }
                              //   }catch(error){
                              //     print(error);
                              //   }
                              //
                              // }

                            },
                            child: const Text('Login',style: TextStyle(
                                color: Colors.white
                            ),),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: const Text('Dont have ana account ?',style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,

                              ),),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                              },
                              child: const Text('Register now',style: TextStyle(
                                  color: PrimaryColor
                              ),),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: const Text('Are you Admin ?',style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,

                              ),),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
                              },
                              child: const Text('Login as Admin now',style: TextStyle(
                                  color: PrimaryColor
                              ),),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: const Text('Are you doctor ?',style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,

                              ),),
                            ),
                            TextButton(
                              onPressed: (){
                                PsychologyCubit.get(context).getUsers();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorLogin()));
                              },
                              child: const Text('Login as doctor now',style: TextStyle(
                                  color: PrimaryColor
                              ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

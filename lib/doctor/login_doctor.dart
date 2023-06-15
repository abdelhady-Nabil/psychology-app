import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:psychology_app/auth/login/login_screen.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';

import '../auth/login/cubit/cubit.dart';
import '../auth/login/cubit/states.dart';
import '../shared/cache_helper.dart';
import '../widget/constant.dart';
import 'doctor_home.dart';
class DoctorLogin extends StatelessWidget {
  DoctorLogin({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController  _EmailTextController = TextEditingController();
  final TextEditingController  _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocProvider(
        create: (BuildContext context)=>LoginCubit(),
        child: BlocConsumer<LoginCubit,LoginState>(
          listener: (context,state ){
            //late var doctorModel = PsychologyCubit.get(context).doctorModel;
            if(state is LoginDoctorSuccessState){
              PsychologyCubit.get(context).getDoctorData();
              CacheHelper.saveData(
                  key: 'userId',
                  value: state.uid
              ).then((value)async{
                uid = state.uid;
                print('hereeeeeee');
                print(uid);
                PsychologyCubit.get(context).getDoctorData();
               await FirebaseFirestore.instance.collection('doctors').doc(uid).snapshots().forEach((element) {
                 if(element.data()?['emil'] == _EmailTextController.text && element.data()?['password']==_passwordController.text){
                   print('i doctor');
                   PsychologyCubit.get(context).getDoctorData();

                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DoctorHomeScreen()));
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
            if(state is LoginDoctorErrorState){
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
                        const Text('Login To Doctor Account',style: TextStyle(
                            fontSize: 30,
                            color: PrimaryColor,
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
                          controller:_EmailTextController ,
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
                            value = _EmailTextController.text;
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
                          controller:_passwordController ,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter your Email";
                            }
                          },

                          onChanged: (value){
                            value = _passwordController.text;
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
                              if(_formKey.currentState!.validate()){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Center(child: CircularProgressIndicator(),),
                                      );
                                    });
                                LoginCubit.get(context).doctorLogin(
                                    email: _EmailTextController.text,
                                    password: _passwordController.text
                                );
                                print(uid);
                                // await FirebaseFirestore.instance.collection('doctors').doc(uid).snapshots().forEach((element) {
                                //   if(element.data()?['emil'] == _EmailTextController.text && element.data()?['password']==_passwordController.text){
                                //     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>DoctorHomeScreen()));
                                //   }
                                // }).catchError((e){
                                //   showDialog(
                                //       context: context,
                                //       builder: (context){
                                //         return AlertDialog(
                                //           title: Text('error Message'),
                                //           content: Text(e.toString()),
                                //         );
                                //       });
                                // });
                                // LoginCubit.get(context).userLogin(
                                //     email: _EmailTextController.text,
                                //     password: _passwordController.text
                                // );
                              }

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
                              child: const Text('Not Doctor ?',style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,

                              ),),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                              },
                              child: const Text('back to Login as user',style: TextStyle(
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

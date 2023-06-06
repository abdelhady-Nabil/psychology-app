import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


import '../../screens/layout/layout_screen.dart';
import '../../widget/constant.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController  _nameTextController = TextEditingController();
  final TextEditingController  _EmailTextController = TextEditingController();
  final TextEditingController  _phoneEmailController = TextEditingController();
  final TextEditingController  _passwordController = TextEditingController();
  final String _gender= 'male' ;

  //indecator progress
  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context,state){},
        builder: (context,state){
          return Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          const Text('Sign UP',style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                label:Text('Enter your Name',style: TextStyle(color: PrimaryColor),),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PrimaryColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PrimaryColor)
                                ),
                                // border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person,color: PrimaryColor,)

                            ),
                            cursorColor: PrimaryColor,
                            controller:_nameTextController ,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter your Name";
                              }
                              return null;
                            },
                            onChanged: (value){
                              value = _nameTextController.text;
                            },
                          ),
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
                                return "Enter your password";
                              }
                            },

                            onChanged: (value){
                              value = _passwordController.text;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              label:Text('Enter your phone',style: TextStyle(color: PrimaryColor),),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.phone,color: PrimaryColor,),
                              prefixText: '+2',
                            ),
                            maxLength: 11,

                            cursorColor: PrimaryColor,
                            controller:_phoneEmailController ,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter your phone";
                              }
                              if(value.length < 11){
                                return "Incorrect phone Number";
                              }
                              return null;
                            },
                            onChanged: (value){
                              value = _phoneEmailController.text;
                            },
                          ),
                          Row(
                            children: [
                              Text('Gender :'),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: DropdownButton<String>(
                                  value: _gender,
                                  //icon: const Icon(Icons.arrow_downward),
                                  //elevation: 16,
                                  style: const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    // setState(() {
                                    //   _gender == value!;
                                    // });
                                  },
                                  items: <String>['male','female'].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            width: double.infinity,
                            height:50,
                            color: PrimaryColor,
                            child: TextButton(
                              onPressed: ()async{
                                //print(email);
                                //print(password);

                                if(_formKey.currentState!.validate()){

                                  RegisterCubit.get(context).userRegister(
                                      name: _nameTextController.text,
                                      email: _EmailTextController.text,
                                      password: _passwordController.text,
                                      phone: _phoneEmailController.text
                                  );

                                  // setState((){
                                  //   showSpinner=true;
                                  // });
                                  // _services.addUserData(data: {
                                  //   "name" : _nameTextController.text,
                                  //   "phone" : _phoneEmailController.text,
                                  //   "email" : _EmailTextController.text,
                                  //   "gender" : _gender,
                                  //   //_services.auth.currentUser
                                  //   //_services.user?.uid
                                  //   "uid": _services.user!.uid,
                                  //   "date" : DateTime.now(),
                                  //   "password" : _passwordController.text,
                                  // });
                                  // try{
                                  //   await _services.auth.createUserWithEmailAndPassword(
                                  //       email: _EmailTextController.text,
                                  //       password: _passwordController.text
                                  //   ).then((user)async{
                                  //     await _services.addUserToFireStore(UserModel(
                                  //         userId: user.user?.uid,
                                  //         email: user.user?.email,
                                  //         name:_nameTextController.text,
                                  //         password: _passwordController.text,
                                  //         phone: _phoneEmailController.text
                                  //     ));
                                  //
                                  //   });
                                  //
                                  // }catch(error){
                                  //   print(error);
                                  // }

                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LayoutScreen()));
                                  // setState((){
                                  //   showSpinner=false;
                                  // });
                                }

                                // try{
                                //   final newUser =await _auth.createUserWithEmailAndPassword(
                                //       email: email,
                                //       password: password
                                //   );
                                //   Navigator.pushReplacement(
                                //       context, MaterialPageRoute(
                                //       builder: (context)=>LayoutScreen()));
                                //
                                // }catch(error){
                                //   print(error);
                                // }

                              },
                              child: const Text('Sign Up',style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

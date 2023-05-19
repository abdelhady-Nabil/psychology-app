import 'package:flutter/material.dart';
import 'package:psychology_app/screens/home_screen.dart';
import 'package:psychology_app/screens/auth/register_screen.dart';

import '../../widget/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  //indecator progress
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
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
                    label:Text('Email',style: TextStyle(color: PrimaryColor),),
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
                  onChanged: (value){
                    email=value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      label:Text('Password',style: TextStyle(color: PrimaryColor),),
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
                  onChanged: (value){
                    password=value;
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
                        setState((){
                          showSpinner=true;
                        });

                        try{
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email,
                              password: password);

                          if(user!=null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            setState((){
                              showSpinner=false;
                            });
                          }
                        }catch(error){
                          print(error);
                        }




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

              ],
            ),
          ),
        ),
      ),
    );
  }
}

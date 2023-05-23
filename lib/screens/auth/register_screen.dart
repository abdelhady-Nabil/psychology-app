import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:psychology_app/screens/auth/login_screen.dart';

import '../../widget/constant.dart';
import '../home_screen.dart';
import '../layout_screen.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
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
                  height: 20,
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


                  onChanged: (value){},
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
                  onChanged: (value){
                    password=value;
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
                      prefixIcon: Icon(Icons.email,color: PrimaryColor,)

                  ),
                  cursorColor: PrimaryColor,
                  onChanged: (value){},
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
                      //print(email);
                      //print(password);
                      try{
                        final newUser =await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password
                        );
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(
                            builder: (context)=>LayoutScreen()));

                      }catch(error){
                        print(error);
                      }

                    },
                    child: const Text('Sign Up',style: TextStyle(
                        color: Colors.white
                    ),),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

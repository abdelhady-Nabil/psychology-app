// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:psychology_app/screens/home_screen.dart';
// import 'package:psychology_app/screens/auth/register_screen.dart';
//
// import '../../services/firebase_services.dart';
// import '../../widget/constant.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
//
// import '../layout_screen.dart';
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   //final _auth = FirebaseAuth.instance;
//   FirebaseServices _services = FirebaseServices();
//   late String email;
//   late String password;
//   final TextEditingController  _EmailTextController = TextEditingController();
//   final TextEditingController  _passwordController = TextEditingController();
//
//   //indecator progress
//   bool showSpinner = false;
//
//   final _formKey = GlobalKey<FormState>();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Form(
//       key: _formKey,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//         body: ModalProgressHUD(
//           inAsyncCall: showSpinner,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children:[
//                   const Text('Login',style: TextStyle(
//                      fontSize: 30,
//                      color: Colors.black,
//                     fontWeight: FontWeight.bold
//                       ),),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                         label:Text('Enter your Email',style: TextStyle(color: PrimaryColor),),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: PrimaryColor)
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: PrimaryColor)
//                         ),
//                         // border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.email,color: PrimaryColor,)
//
//                     ),
//                     cursorColor: PrimaryColor,
//                     controller:_EmailTextController ,
//                     validator: (value){
//                       if(value!.isEmpty){
//                         return "Enter your Email";
//                       }
//                       final bool isValid = EmailValidator.validate(value);
//                       if(!isValid){
//                         return "Invalid Email Address";
//                       }
//                       return null;
//                     },
//                     onChanged: (value){
//                       value = _EmailTextController.text;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       label:Text('Enter your Password',style: TextStyle(color: PrimaryColor),),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: PrimaryColor)
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: PrimaryColor)
//                       ),
//                       // border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.lock,color: PrimaryColor,),
//                       suffixIcon: Icon(Icons.remove_red_eye,color: PrimaryColor,),
//
//                     ),
//                     cursorColor: PrimaryColor,
//                     controller:_passwordController ,
//                     validator: (value){
//                       if(value!.isEmpty){
//                         return "Enter your Email";
//                       }
//                     },
//
//                     onChanged: (value){
//                       value = _passwordController.text;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     alignment: Alignment.topRight,
//                     child: const Text('Forget password?',style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//
//                     ),),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: double.infinity,
//                     height:50,
//                     color: PrimaryColor,
//                     child: TextButton(
//                         onPressed: ()async{
//
//                           if(_formKey.currentState!.validate()){
//                             setState((){
//                               showSpinner=true;
//                             });
//                             try{
//                               final user = await _services.auth.signInWithEmailAndPassword(
//                                   email: _EmailTextController.text,
//                                   password: _passwordController.text
//                               );
//                               if(user!=null){
//                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
//                                 setState((){
//                                   showSpinner=false;
//                                 });
//                               }
//                             }catch(error){
//                               print(error);
//                             }
//
//                           }
//
//                         },
//                         child: const Text('Login',style: TextStyle(
//                           color: Colors.white
//                         ),),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         child: const Text('Dont have ana account ?',style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.black,
//
//                         ),),
//                       ),
//                       TextButton(
//                           onPressed: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
//                           },
//                           child: const Text('Register now',style: TextStyle(
//                             color: PrimaryColor
//                           ),),
//                       ),
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

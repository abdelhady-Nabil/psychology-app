import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:psychology_app/model/user_model.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/layout/cubit/states.dart';
import 'package:psychology_app/screens/layout/layout_screen.dart';
import 'package:psychology_app/screens/setting_screen.dart';
import 'package:psychology_app/shared/cache_helper.dart';
import 'package:psychology_app/user_provider.dart';
import 'package:psychology_app/widget/constant.dart';

import '../auth/login/login_screen.dart';
import '../services/firebase_services.dart';

class MoreScreen extends StatelessWidget {
   MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit,PsychologyState>(
      listener: (context,state){},
      builder: (context,state){
       var userModel = PsychologyCubit.get(context).model;
        userModel.userId=uid;
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[200],

            body:SingleChildScrollView(
              child: Column(

                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        color: PrimaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text('ملفك الشخصي',style: TextStyle(color: Colors.white,fontSize: 20),),
                              IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
                              }, icon: Icon(Icons.arrow_forward,color: Colors.white,)),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 150,
                        //right: 10,
                        //height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            width: 350,
                            height: 150,
                            child: Center(
                              child: CircleAvatar(
                                backgroundImage: AssetImage("images/man.png"),
                                backgroundColor: Colors.transparent,
                                radius: 60,
                              ),
                            ),

                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 70,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: IconButton(
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Icon(Icons.person,color: PrimaryColor,),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('${userModel.name}',style: TextStyle(fontSize: 18),),
                                  ],
                                ),
                                onPressed: (){
                                  print('${userModel.name}');
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: IconButton(
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Icon(Icons.phone,color: PrimaryColor,),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('+2 ${userModel.phone}',style: TextStyle(fontSize: 18),),
                                  ],
                                ),
                                onPressed: (){
                                  print(userModel.phone);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: IconButton(
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Icon(Icons.email_outlined,color: PrimaryColor,),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('${userModel.email}',style: TextStyle(fontSize: 18),),
                                  ],
                                ),
                                onPressed: (){
                                 print(userModel.email);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: IconButton(
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Icon(Icons.lock_outline,color: PrimaryColor,),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('**********',style: TextStyle(fontSize: 18),),
                                  ],
                                ),
                                onPressed: ()async{
                                  print(userModel.password);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: IconButton(
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.manage_accounts_outlined,color: PrimaryColor,),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('setting',style: TextStyle(fontSize: 18),),
                                  ],
                                ),
                                onPressed: ()async{
                                  print(userModel.password);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: IconButton(
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Icon(Icons.logout_outlined,color: PrimaryColor,),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Log out',style: TextStyle(fontSize: 18),),
                                  ],
                                ),
                                onPressed: (){
                                  //_auth.signOut();
                                  FirebaseAuth.instance.signOut();
                                  PsychologyCubit.get(context).signOut(context);
                                  print('log out');
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                                  //print('log out');
                                },
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ],
              ),
            ),


            // body: SingleChildScrollView(
            //   child: Column(
            //
            //     children: [
            //       Stack(
            //
            //         clipBehavior: Clip.none,
            //         alignment: Alignment.bottomRight,
            //         children: [
            //           Container(
            //             width: double.infinity,
            //             height: 250,
            //             color: PrimaryColor,
            //             child: Padding(
            //               padding: const EdgeInsets.all(20.0),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.end,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //
            //                   Text('ملفك الشخصي',style: TextStyle(color: Colors.white,fontSize: 20),),
            //                   IconButton(onPressed: (){
            //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
            //                   }, icon: Icon(Icons.arrow_forward,color: Colors.white,)),
            //                 ],
            //               ),
            //             ),
            //           ),
            //           Positioned(
            //             top: 150,
            //             //right: 10,
            //             //height: 100,
            //             child: Padding(
            //               padding: const EdgeInsets.all(20.0),
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.circular(10)
            //                 ),
            //                 width: 350,
            //                 height: 150,
            //                 child: Center(
            //                   child: CircleAvatar(
            //                     backgroundImage: AssetImage("images/man.png"),
            //                     backgroundColor: Colors.transparent,
            //                     radius: 60,
            //                   ),
            //                 ),
            //
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 70,
            //       ),
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //
            //           SizedBox(
            //             height: 20,
            //           ),
            //           Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
            //                 child: Container(
            //                   width: double.infinity,
            //                   height: 50,
            //                   decoration: BoxDecoration(
            //                       color: Colors.grey[350],
            //                     borderRadius: BorderRadius.circular(10)
            //                   ),
            //                   child: IconButton(
            //                     icon: Row(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //
            //                       children: [
            //                         Icon(Icons.person,color: PrimaryColor,),
            //                         SizedBox(
            //                           width: 20,
            //                         ),
            //                         Text('Abdelhady Nabil',style: TextStyle(fontSize: 18),),
            //                       ],
            //                     ),
            //                     onPressed: (){
            //                       //_auth.signOut();
            //                       FirebaseAuth.instance.signOut();
            //                       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
            //                       print('log out');
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
            //                 child: Container(
            //                   width: double.infinity,
            //                   height: 50,
            //                   decoration: BoxDecoration(
            //                       color: Colors.grey[350],
            //                       borderRadius: BorderRadius.circular(10)
            //                   ),
            //                   child: IconButton(
            //                     icon: Row(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //
            //                       children: [
            //                         Icon(Icons.phone,color: PrimaryColor,),
            //                         SizedBox(
            //                           width: 20,
            //                         ),
            //                         Text('+2 01159398456',style: TextStyle(fontSize: 18),),
            //                       ],
            //                     ),
            //                     onPressed: (){
            //                       //_auth.signOut();
            //                       FirebaseAuth.instance.signOut();
            //                       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
            //                       print('log out');
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
            //                 child: Container(
            //                   width: double.infinity,
            //                   height: 50,
            //                   decoration: BoxDecoration(
            //                       color: Colors.grey[350],
            //                       borderRadius: BorderRadius.circular(10)
            //                   ),
            //                   child: IconButton(
            //                     icon: Row(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //
            //                       children: [
            //                         Icon(Icons.email_outlined,color: PrimaryColor,),
            //                         SizedBox(
            //                           width: 20,
            //                         ),
            //                         Text('Abdelhady@gmail.com',style: TextStyle(fontSize: 18),),
            //                       ],
            //                     ),
            //                     onPressed: (){
            //                       //_auth.signOut();
            //                       FirebaseAuth.instance.signOut();
            //                       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
            //                       print('log out');
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
            //                 child: Container(
            //                   width: double.infinity,
            //                   height: 50,
            //                   decoration: BoxDecoration(
            //                       color: Colors.grey[350],
            //                       borderRadius: BorderRadius.circular(10)
            //                   ),
            //                   child: IconButton(
            //                     icon: Row(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //
            //                       children: [
            //                         Icon(Icons.lock_outline,color: PrimaryColor,),
            //                         SizedBox(
            //                           width: 20,
            //                         ),
            //                         Text('**********',style: TextStyle(fontSize: 18),),
            //                       ],
            //                     ),
            //                     onPressed: (){
            //                       //_auth.signOut();
            //                       FirebaseAuth.instance.signOut();
            //                       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
            //                       print('log out');
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20),
            //                 child: Container(
            //                   width: double.infinity,
            //                   height: 50,
            //                   decoration: BoxDecoration(
            //                       color: Colors.grey[350],
            //                       borderRadius: BorderRadius.circular(10)
            //                   ),
            //                   child: IconButton(
            //                     icon: Row(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //
            //                       children: [
            //                         Icon(Icons.logout_outlined,color: PrimaryColor,),
            //                         SizedBox(
            //                           width: 20,
            //                         ),
            //                         Text('Log out',style: TextStyle(fontSize: 18),),
            //                       ],
            //                     ),
            //                     onPressed: (){
            //                       //_auth.signOut();
            //                       FirebaseAuth.instance.signOut();
            //                       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
            //                       print('log out');
            //                     },
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           )
            //
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ),
        );
      },
    );
  }
}

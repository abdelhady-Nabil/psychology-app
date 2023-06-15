import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/doctor/add_new_time.dart';
import 'package:psychology_app/doctor/video_call.dart';
import 'package:psychology_app/widget/constant.dart';

import '../admin/patient_screen.dart';
import '../auth/login/login_screen.dart';
import '../screens/chat_user/chat_user_screen.dart';
import '../screens/layout/cubit/cubit.dart';
import '../screens/layout/cubit/states.dart';
import 'all_date.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit, PsychologyState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model =PsychologyCubit.get(context).doctorModel;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: PrimaryColor,
              title: Text('Dashboard'),
              actions: [
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      PsychologyCubit.get(context).signOut(context);
                      print('log out');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    icon: Icon(Icons.logout)),
              ],
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                children:  [
                  //header
                  Container(
                    color: PrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('images/dd.png'),
                            radius: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Dr ${model.name}',style: TextStyle(color: Colors.white),),
                          Text('${model.email}',style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      //PsychologyCubit.get(context).getUsers();

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllDate()));
                    },
                    title: Text('all Date'),
                    leading: Icon(Icons.schedule_outlined),
                  ),
                  ListTile(
                    onTap: (){
                      //PsychologyCubit.get(context).getUsers();

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatUserScreen()));
                    },
                    title: Text('chats'),
                    leading: Icon(Icons.chat),
                  ),
                  ListTile(
                    onTap: (){
                      PsychologyCubit.get(context).getUsers();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>VideoCall()));
                    },
                    title: Text('video cll'),
                    leading: Icon(Icons.video_call_outlined),
                  ),
                  ListTile(
                    title: Text('patient'),
                    leading: Icon(Icons.sick_outlined),
                    onTap: (){
                      PsychologyCubit.get(context).getUsers();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>PatientScreen()));

                    },
                  ),

                  ListTile(
                    title: Text('Booking'),
                    leading: Icon(Icons.local_activity_outlined),
                  ),
                  ListTile(
                    title: Text('Earning'),
                    leading: Icon(Icons.monetization_on_outlined),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                    onTap: (){
                      PsychologyCubit.get(context).signOut(context);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                    },
                    title: Text('log out'),
                    leading: Icon(Icons.logout),
                  ),


                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text('Welcome back'),
                            Text(
                              'Dr. ${model.name}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTime()));
                            }, icon: Icon(Icons.add_circle_outline_outlined)),
                            Text('add anew time')
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('حجوزات اليوم',style: TextStyle(fontSize: 20,color: PrimaryColor),),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    width: double.infinity,
                    height: 100,
                    child:  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          //day
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text( 'Ahmed    ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),
                              Text( ': اسم المريض ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),


                            ],
                          ),

                          //time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text( '6:00    ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),
                              Text( ': الساعه ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),


                            ],
                          ),

                          //

                        ],
                      ),
                    ),

                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

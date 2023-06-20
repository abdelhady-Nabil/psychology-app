import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:psychology_app/screens/chat_screen.dart';
import 'package:psychology_app/screens/how_screen.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/measure/measure_screen.dart';
import 'package:psychology_app/screens/more_screen.dart';
import 'package:psychology_app/screens/measure/test_screen.dart';
import 'package:psychology_app/screens/search_screen.dart';
import 'package:psychology_app/screens/time_screen.dart';
import 'package:psychology_app/widget/constant.dart';

import '../auth/login/login_screen.dart';
import '../booking/booking_screen.dart';
import '../model/doctor_model.dart';
import '../model/question_model.dart';
import '../widget/custom_item.dart';
import '../widget/custom_text.dart';
import 'call/start_call.dart';
import 'chat_doctor/chat_doctor_screen.dart';
import 'doctor_details.dart';
import 'face_detection.dart';
import 'layout/cubit/states.dart';
import 'measure/goal_measure.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  List <QuestionModel> questionList = getQuestion();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit,PsychologyState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,

          body: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Row(
                          children:  [
                            IconButton(onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>HowScreen()));

                            }, icon:Icon(Icons.question_mark_outlined,color: Colors.deepPurpleAccent,), ),

                            SizedBox(
                              width: 5,
                            ),
                            IconButton(onPressed: (){
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>TimeScreen()));

                            }, icon:Icon(Icons.calendar_month_outlined,color: Colors.deepPurpleAccent,), ),

                          ],
                        ),
                        CustomText(
                          text: 'طبيبك النفسي',
                          fontSize: 20,
                          color: PrimaryColor,
                        ),
                         IconButton(icon:Icon(Icons.logout,color: Colors.deepPurpleAccent),onPressed:(){
                           //print(model.userId);
                           PsychologyCubit.get(context).signOut(context);
                           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                           

                         }),

                      ],
                    ),
                    Row(
                      children: [

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FaceDetection()));
                          },
                          child: Container(
                            width: 170,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.tealAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text('ما هو شعورك اليوم ؟')),

                          ),
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: const [
                            Text(', اهلا بك',style: TextStyle(color: Colors.grey,fontSize: 20),),
                            Text('من جديد',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),

                      ],
                    ) ,
                    const SizedBox(
                      height: 20,
                    ),
                    //banner show
                    Container(
                      width:double.infinity,
                      height: 150,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                offset: Offset(4, 8)

                            ),

                          ]
                      ),
                      child:ImageSlideshow(
                        width: double.infinity,
                        height: 90,
                        initialPage: 0,
                        indicatorColor: PrimaryColor,
                        indicatorBackgroundColor: Colors.grey,
                        children: [
                          Image.asset(
                            'images/help.png',
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            'images/b1.png',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'images/b2.png',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'images/b3.jpg',
                            fit: BoxFit.cover,
                          ),
                        ],
                        autoPlayInterval: 3000,
                        isLoop: true,
                      ),
                    ),


                    const SizedBox(
                      height: 40,
                    ),

                    //Search bar
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));

                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.search,color: Colors.grey,),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('ابحث عن طبيبك',style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                        }, icon: Icon(Icons.person_search,color: PrimaryColor,size: 35,)),

                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        const Icon(Icons.arrow_downward_outlined,size: 20),
                        CustomText(
                          text: '(و اختبر نفسك )',
                          fontSize: 15,
                          color: Colors.black,

                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(' ! ابدا رحلتك الان',style: TextStyle(color: PrimaryColor,fontWeight: FontWeight.bold,fontSize: 20),),

                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children:  [
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MeasureScreen()));
                          },
                          child: CustomText(
                            text: 'عرض الكل',
                            fontSize: 12,
                            color: Colors.grey,

                          ),
                        ),
                        Spacer(),
                        CustomText(
                          text: 'مقاييس التشخيص',
                          fontSize: 15,
                          color:PrimaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CustomItem(
                            title:'مقياس تقدير الذات',
                            image: 'images/3.png',
                            number: 8,
                            color: Colors.teal,
                            function: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>GoalMeasure(
                                title:'مقياس تقدير الذات',
                                image: 'images/3.png',
                                number: 8,
                                color: Colors.teal,
                              )));
                            },
                          ),
                          CustomItem(
                            title:'مقياس الرضا الزواجي',
                            image: 'images/1.png',
                            number: 9,
                            color: Colors.pink,
                            function:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>GoalMeasure(
                                title:'مقياس الرضا الزواجي',
                                image: 'images/1.png',
                                number: 9,
                                color: Colors.pink,
                              )));
                            },

                          ),
                          CustomItem(
                            title:'مقياس الاكتئاب الحاد',
                            image: 'images/5.png',
                            number: 10,
                            color: Colors.deepPurpleAccent,
                            function: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>GoalMeasure(
                                title:'مقياس الاكتئاب الحاد',
                                image: 'images/5.png',
                                number: 10,
                                color: Colors.deepPurpleAccent,
                              )));
                            },

                          ),
                          CustomItem(
                            title:'مقياس القلق الدائم',
                            image: 'images/4.png',
                            number: 10,
                            color: Colors.deepOrange,
                            function: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>GoalMeasure(
                                title:'مقياس القلق الدائم',
                                image: 'images/4.png',
                                number: 10,
                                color: Colors.deepOrange,
                              )));
                            },

                          ),
                          CustomItem(
                            title:'مقياس الوسواس ',
                            image: 'images/2.png',
                            number: 10,
                            color: Colors.indigo,
                            function: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>GoalMeasure(
                                title:'مقياس الوسواس ',
                                image: 'images/2.png',
                                number: 10,
                                color: Colors.indigo,
                              )));
                            },

                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),


                    Row(
                      children:  [
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                          },
                          child: CustomText(
                            text: 'عرض الكل',
                            fontSize: 12,
                            color: Colors.grey,

                          ),
                        ),
                        Spacer(),
                        CustomText(
                          text:'اوجد طبيبك',
                          fontSize: 15,
                          color:PrimaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),


                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                          physics: ClampingScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,

                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index)=>DoctorItem(context,PsychologyCubit.get(context).doctors[index]),
                          separatorBuilder: (context,index)=> SizedBox(
                            width: 10,
                          ),
                          itemCount: PsychologyCubit.get(context).doctors.length),
                    ),
                  ],
                ),
              ),
            ),
          ),

        );
      },

    );
  }

  Widget DoctorItem(context,DoctorModel model){
    return GestureDetector(
      onTap: (){
        Scaffold.of(context).showBottomSheet((context){
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[10],
              borderRadius: BorderRadius.circular(40)
            ),
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: PrimaryColor,
                      backgroundImage: AssetImage('images/dd.png'),
                      radius: 60,
                    ),
                    Text('Dr. ${model.name}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    Text('طبيب نفسي',style: TextStyle(fontSize: 20,color: Colors.grey),),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            radius: 35,
                            child: IconButton(
                              icon: Icon(Icons.chat,color: PrimaryColor,),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDoctorScreen()));

                              },
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            radius: 35,
                            child: IconButton(
                              icon: Icon(Icons.video_call_outlined,color: PrimaryColor),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>StartCall()));
                              },
                            ),
                          ),

                          CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            radius: 35,
                            child: IconButton(
                              icon: Icon(Icons.read_more,color: PrimaryColor),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDetails(model: model,)));

                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                        child: Text('الانجازات',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),

                    Container(
                      width: double.infinity,
                      height: 200,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      child: Image.asset('images/aa.png'),
                                    width: 100,
                                    height: 100,
                                  ),
                                  Text('120+',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  Text('مريض'),

                                ],

                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Image.asset('images/bb.png'),
                                    width: 100,
                                    height: 100,
                                  ),
                                  Text('5+',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  Text('خبره'),

                                ],

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),



                    Container(
                      width: double.infinity,
                      height: 50,

                      decoration: BoxDecoration(
                          color: PrimaryColor,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextButton(onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>BookingScreen(name:model.name,doctorid: model.doctorId,)));
                      }, child:Text('احجز الان',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                    ),


                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child:Text('رجوع',style: TextStyle(color: Colors.black),)),

                  ],
                ),
              ),
            ),
          );
        });
      },
      child: Column(
        children: [
          Container(
            height: 120,
            width: 170,
            child: Image.asset('images/dd.png'),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Dr. ${model.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
        ],
      ),
    );
  }
}

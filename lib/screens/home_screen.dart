import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/screens/chat_screen.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/measure/measure_screen.dart';
import 'package:psychology_app/screens/more_screen.dart';
import 'package:psychology_app/screens/measure/test_screen.dart';
import 'package:psychology_app/screens/time_screen.dart';
import 'package:psychology_app/widget/constant.dart';

import '../auth/login/login_screen.dart';
import '../model/question_model.dart';
import '../widget/custom_item.dart';
import '../widget/custom_text.dart';
import 'layout/cubit/states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  List <QuestionModel> questionList = getQuestion();
  int index = 4;
  List<Widget>screens=[
    ChatScreen(),
    TimeScreen(),
    MeasureScreen(),
    MoreScreen(),
  ];


  void getCurrentUser(){

    try{
      final user = _auth.currentUser;
      if(user != null){
        signedInUser= user;
        print(signedInUser.email);
      }
    }
    catch(error){
      print(error);

    }



  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit,PsychologyState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Row(
                          children: const [
                            Icon(Icons.question_mark_outlined,color: Colors.deepPurpleAccent,),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.shopping_cart,color: Colors.deepPurpleAccent,),
                          ],
                        ),
                        CustomText(
                          text: 'طبيبك النفسي',
                          fontSize: 20,
                          color: PrimaryColor,
                        ),
                        const Icon(Icons.add_alert,color: Colors.deepPurpleAccent,),

                      ],
                    ),
                    Row(
                      children: [

                        Container(
                          width: 170,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.tealAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text('ما هو شعورك اليوم ؟')),

                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: const [
                            Text(', اهلا بك',style: TextStyle(color: Colors.grey,fontSize: 20),),
                            Text('في عيادتك',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

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
                    Container(
                      width:double.infinity,
                      height: 100,
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
                      child:Image.asset('images/help.png',fit: BoxFit.fill,),
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
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>TestScreen(
                                        start: 0,
                                        end: 8,
                                        title: 'مقياس تقدير الذات',
                                      )));
                            },
                          ),
                          CustomItem(
                            title:'مقياس الرضا الزواجي',
                            image: 'images/1.png',
                            number: 9,
                            color: Colors.pink,
                            function:(){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>TestScreen(
                                        start: 8,
                                        end: 16,
                                        title: 'مقياس الرضا الزواجي',
                                      )));
                            },

                          ),
                          CustomItem(
                            title:'مقياس الاكتاب الحاد',
                            image: 'images/5.png',
                            number: 10,
                            color: Colors.deepPurpleAccent,
                            function: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>TestScreen(
                                        start: 11,
                                        end: 15,
                                        title: 'مقياس الاكتاب الحاد',
                                      )));
                            },

                          ),
                          CustomItem(
                            title:'مقياس القلق الدائم',
                            image: 'images/4.png',
                            number: 10,
                            color: Colors.deepOrange,
                            function: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>TestScreen(
                                        start: 16,
                                        end: 20,
                                        title: 'مقياس القلق الدائم',
                                      )));
                            },

                          ),
                          CustomItem(
                            title:'مقياس الوسواس ',
                            image: 'images/2.png',
                            number: 10,
                            color: Colors.indigo,
                            function: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>TestScreen(
                                        start: 20,
                                        end: 25,
                                        title: 'مقياس الوسواس',
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
                        CustomText(
                          text: 'عرض الكل',
                          fontSize: 10,
                          color: Colors.grey,

                        ),
                        Spacer(),
                        CustomText(
                          text: 'مجموعات الدعم',
                          fontSize: 15,
                          color:PrimaryColor,
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Image.asset('images/1.png'),
                                width: 100,
                                height: 100,
                              ),
                              Text('General'),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Container(
                                child: Image.asset('images/children.png'),
                                width: 100,
                                height: 100,
                              ),
                              Text('child'),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Container(
                                child: Image.asset('images/g.jpg'),
                                width: 100,
                                height: 100,
                              ),
                              Text('General'),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children:[
                              Container(
                                child: Image.asset('images/g.jpg'),
                                width: 100,
                                height: 100,
                              ),
                              Text('General'),
                            ],
                          ),
                        ],
                      ),
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

}

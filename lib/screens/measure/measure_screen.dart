import 'package:flutter/material.dart';
import 'package:psychology_app/screens/home_screen.dart';
import 'package:psychology_app/screens/measure/test_screen.dart';
import 'package:psychology_app/widget/constant.dart';
import 'package:psychology_app/widget/custom_item.dart';

import '../../model/question_model.dart';
import '../../widget/custom_item_list.dart';
import '../../widget/custom_text.dart';
import 'goal_measure.dart';
class MeasureScreen extends StatelessWidget {

  List <QuestionModel> questionList = getQuestion();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: Padding(
         padding: const EdgeInsets.only(top: 20),
         child: SafeArea(
           child: SingleChildScrollView(
             child: Column(
             crossAxisAlignment: CrossAxisAlignment.end,
               children: [

                 Container(
                   alignment: Alignment.center,
                   child: Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Row(
                       children: [
                         // IconButton(
                         //   onPressed: (){
                         //     Navigator.push(context,
                         //         MaterialPageRoute(
                         //             builder: (context)=>HomeScreen()));
                         //   },
                         //   icon: Icon(Icons.arrow_back),
                         // ),
                         Spacer(),
                         CustomText(
                             text: 'مقاييس التشخيص',
                             fontSize: 20,
                           color: PrimaryColor,
                         ),
                       ],
                     ),
                   ),
                 ),
                 const SizedBox(
                   height: 20,
                 ),
                 Row(
                   children: [
                     CustomItemList(
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
                         // Navigator.push(context,
                         //     MaterialPageRoute(
                         //         builder: (context)=>TestScreen(
                         //           start: 0,
                         //           end: 8,
                         //           title: 'مقياس تقدير الذات',
                         //         )));
                       },
                     ),
                     CustomItemList(
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
                   ],
                 ),
                 const SizedBox(
                   height: 20,
                 ),
                 Row(
                   children: [
                     CustomItemList(
                       title:'مقياس الاكتاب الحاد',
                       image: 'images/5.png',
                       number: 10,
                       color: Colors.deepPurpleAccent,
                       function: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>GoalMeasure(
                           title:'مقياس الاكتاب الحاد',
                           image: 'images/5.png',
                           number: 10,
                           color: Colors.deepPurpleAccent,
                         )));
                       },

                     ),
                     CustomItemList(
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

                   ],
                 ),
                 const SizedBox(
                   height: 20,
                 ),

                 Row(
                   children: [
                     CustomItemList(
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

               ],
             ),
           ),
         ),
       ),
     ),
    );
  }
}

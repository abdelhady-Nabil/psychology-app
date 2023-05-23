

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psychology_app/screens/measure/test_screen.dart';

import '../../widget/constant.dart';
import '../../widget/custom_text.dart';
class GoalMeasure extends StatefulWidget {
   GoalMeasure({Key? key,required this.title,required this.image,required this.number,required this.color}) : super(key: key);

  final String title;
  final String image;
  final int number;
   final Color color;





  @override
  State<GoalMeasure> createState() => _GoalMeasureState();
}

class _GoalMeasureState extends State<GoalMeasure> {
   late String title = widget.title;
   late String image = widget.image;
   late int number = widget.number;
   late Color color = widget.color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      alignment:Alignment.bottomCenter,
                      children: [
                        Container(
                            color: color,
                            width: double.infinity,
                            height: 200,
                            child: Image.asset('$image')),
                        Column(
                          children: [
                            CustomText(text: '$title', fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),
                            CustomText(text: '$number  سؤال', fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold,),

                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward,color: Colors.white,),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),


            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                width: double.infinity,
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: CustomText(
                          text: 'هدفنا من هذا المقياس هو تقييم الرضا الزواجي لديك لنتمكن من تقديم الاستشاره النافعه لك  لنتمكن من تقديم الاستشاره النافعه لك ومساعدتك في تحسين صحتك النفسيه بشكل افضل',
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: CustomText(
                          text: '! ننبهك من جديد - ',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: CustomText(
                          text: 'جميع المقاييس ماهي الا اداه للقياس  وليست اداه تشخيص نهائيه وعليةنؤكد علي ضرورة استشارةالاخصائي',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),


            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 50,

                decoration: BoxDecoration(
                    color: PrimaryColor,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: TextButton(
                    onPressed: (){
                      switch(title) {
                        case 'مقياس تقدير الذات': {
                          // statements;
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>TestScreen(
                                    start: 0,
                                    end: 8,
                                    title:title,
                                  )));
                        }
                        break;
                        case 'مقياس الرضا الزواجي': {
                          // statements;
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>TestScreen(
                                    start: 8,
                                    end: 16,
                                    title: 'مقياس الرضا الزواجي',
                                  )));
                        }
                        break;
                        case 'مقياس الاكتاب الحاد': {
                          // statements;
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>TestScreen(
                                    start: 11,
                                    end: 15,
                                    title: 'مقياس الاكتاب الحاد',
                                  )));
                        }
                        break;
                        case 'مقياس القلق الدائم': {
                          // statements;
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>TestScreen(
                                    start: 16,
                                    end: 20,
                                    title: 'مقياس القلق الدائم',
                                  )));
                        }
                        break;
                        case 'مقياس الوسواس ': {
                          // statements;
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>TestScreen(
                                    start: 20,
                                    end: 25,
                                    title: 'مقياس الوسواس',
                                  )));
                        }
                        break;
                      }

                    },
                    child: const Text('بدا المقياس',style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

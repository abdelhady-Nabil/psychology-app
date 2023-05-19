

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/constant.dart';
import '../../widget/custom_text.dart';
class GoalMeasure extends StatefulWidget {
  const GoalMeasure({Key? key}) : super(key: key);

  @override
  State<GoalMeasure> createState() => _GoalMeasureState();
}

class _GoalMeasureState extends State<GoalMeasure> {
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
                            color: Colors.pink,
                            width: double.infinity,
                            height: 200,
                            child: Image.asset('images/1.png')),
                        Column(
                          children: [
                            CustomText(text: 'مقياس الرضا الزواجي', fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),
                            CustomText(text: '15 سؤال', fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold,),

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
                    onPressed: (){},
                    child: Text('بدا المقياس',style: TextStyle(
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

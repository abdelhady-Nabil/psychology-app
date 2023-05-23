import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:psychology_app/widget/custom_text.dart';

import '../../widget/constant.dart';
class ReasultScreen extends StatefulWidget {

  final int score ;

  ReasultScreen({required this.score});

  @override
  State<ReasultScreen> createState() => _ReasultScreenState();
}

class _ReasultScreenState extends State<ReasultScreen> {

  late int score = widget.score;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            children:  [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(

                  children: [


                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('النتيجه',style: const TextStyle(
                            fontSize: 20,
                            color: PrimaryColor
                        ),),

                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                color: Colors.white,
                height: 200,
                child: CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 15.0,
                  animation: true,
                  percent: score/100,
                  center: Text('$score %',style: TextStyle(fontSize: 40),),
                  //footer:  Text('$score %',style: TextStyle(fontSize: 10),),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: PrimaryColor,
                ),
              ),

              Expanded(
                child: Container(

                  width: double.infinity,
                  child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: '! غير راضي عن صوره جسدك', fontSize: 20,fontWeight: FontWeight.bold),
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(text: 'نذكر ان هذا المقياس مساعد للتشخيص المبدائي ولا يعتبر تشخيصا نهائيا استمر في المتابعه مع الاخصائي لمساعدتك في تحسين نظرتك لصوره جسدك ورفع مستوي الثقه لديك\n\nاستمر في المتابعه مع الاخصائي لمساعدتك في تحسين صحتك النفسيه والوصول للراحه التي تعيدك للحياةمستمرة', fontSize: 15)
                    ],
                  ),
                  
                ),
              ),

              Container(
                width: double.infinity,
                height: 50,

                decoration: BoxDecoration(
                    color: PrimaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: TextButton(
                    onPressed: (){},
                    child: Text('ناقش نتيجتك مع الاخصائي',style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),

                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

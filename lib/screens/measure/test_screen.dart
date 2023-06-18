import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:psychology_app/screens/measure/reasult_screen.dart';
import 'package:psychology_app/widget/constant.dart';
import '../../model/question_model.dart';
class TestScreen extends StatefulWidget {
  final String title;
   final int start;
  final int end;


  TestScreen({
    required this.title,
     required this.start,
    required this.end,
});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  List <QuestionModel> questionList = getQuestion();
  late int currentQuestionIndex = widget.start;
  late int endQuestionIndex = widget.end;
  int score = 0;
  Answer? selectedAnswer;

  double startPercent = 0.1;


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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(

                  children: [


                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(widget.title,style: const TextStyle(
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


              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
                  LinearPercentIndicator(
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 500,
                    percent: startPercent,
                    barRadius: Radius.circular(20),
                    progressColor: PrimaryColor,
                    backgroundColor: Colors.grey[400],

                  ),
                  // Text('السؤال ${currentQuestionIndex+1} / ${endQuestionIndex}',style: const TextStyle(
                  //     fontSize: 18,
                  //     color: Colors.black,
                  //   fontWeight: FontWeight.bold
                  // ),),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.15,

                    decoration: BoxDecoration(
                      color:PrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Center(child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(questionList[currentQuestionIndex].questionText,style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                      ),
                      textAlign: TextAlign.end,
                      ),
                    )),

                  ),

                ],
              ),
              _answerList(),
              _nextButton(),


            ],
          ),
        ),
      ),
    );
  }
  _answerList(){
    return Column(
      children: questionList[currentQuestionIndex].answerList.map((e) => _answerButton(e)).toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(answer.answerText),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? PrimaryColor : Colors.grey[400],
          onPrimary: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          startPercent+=0.1;
          if (selectedAnswer == null) {
            if (answer.isCorrect) {
              score+=10;
            }
            setState(() {
              selectedAnswer = answer;
            });
          }
        },
      ),
    );
  }
  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == endQuestionIndex-1) {
      isLastQuestion = true;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        child: Text(isLastQuestion ? "تاكيد" : "التالي"),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: PrimaryColor,
          onPrimary: Colors.white,
        ),
        onPressed: (){
          if(isLastQuestion){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReasultScreen(score: score,)));
          }else{
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
            });
          }
        },
      ),
    );
  }
}
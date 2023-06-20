import 'package:flutter/material.dart';
import 'package:psychology_app/payment/fawrey_screen.dart';
import 'package:psychology_app/payment/visa_screen.dart';

import '../payment/vodafone_screen.dart';
import '../widget/constant.dart';
class ChosePayment extends StatelessWidget {

  ChosePayment({
    Key? key,
    required this.doctorName,
    required this.userName,
    required this.price,
    required this.time,
    required this.day,
    required this.userId,
    required this.doctorId

  }) : super(key: key);

  String doctorName;
  String doctorId;
  String userName;
  String userId;
  String day;
  String time;
  String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        centerTitle: true,
        title: Text('اختار طريقه الدفع  '),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            payItem(
              name: 'فودافون كاش',
              title: 'التحويل عن طريق محفظه فودافون كاش',
              image: 'images/vodafone.jpg',
              function: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VodafoneScreen(
                          doctorName: doctorName,
                          userName: userName,
                          time:time,
                          price: price,
                          day: day,
                          userId: userId,
                          doctorId: doctorId,

                        )));
              }

            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: PrimaryColor,
            ),
            SizedBox(
              height: 20,
            ),
            payItem(
              name: 'فوري ',
              title: ' ادفع في اقرب مكان به ماكينه فوري',
              image: 'images/fawry.png',
                function: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FawreyScreen(
                            doctorName: doctorName,
                            userName: userName,
                            time:time,
                            price: price,
                            day: day,
                            userId: userId,
                            doctorId: doctorId,

                          )));
                }
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: PrimaryColor,
            ),
            SizedBox(
              height: 20,
            ),
            // payItem(
            //   name: 'visa ',
            //   title: '           ادفع عن طريق الفيزا الخاصه بك',
            //   image: 'images/visa.png',
            //     function: (){
            //       Navigator.push(context, MaterialPageRoute(builder: (contect)=>VisaScreen()));
            //     }
            // ),

          ],
        ),
      ),

    );
  }

  Widget payItem({
  required String name,
    required String title,
    required String image,
    required Function function
}){
    return GestureDetector(
      onTap: (){
        function();
      },
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                    child: Image.asset(image,fit: BoxFit.cover,)),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text(title,style: TextStyle(fontSize: 14,color: Colors.grey),),
                ],
              ),

            ],
          ),
        ),
      ),
    );

  }
}

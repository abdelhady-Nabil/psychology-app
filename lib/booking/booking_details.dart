import 'package:flutter/material.dart';
import 'package:psychology_app/widget/constant.dart';

import '../model/date_model.dart';
import 'chosse_payment.dart';
import 'confirm_booking.dart';

class BookingDetails extends StatelessWidget {
  BookingDetails(
      {Key? key,
      required this.model,
      required this.doctorName,
        required this.doctorId,
      required this.userName,
      required this.userId,
      })
      : super(key: key);

  DateModel model;
  String doctorName;
  String userName;
  String userId;
  String doctorId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        centerTitle: true,
        title: Text('معلومات الحجز'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                child: Text(
                  ' $doctorName     حجز مع دكتور',
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${model.day}',
                          style: TextStyle(fontSize: 18, color: PrimaryColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          ': اليوم  ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${model.time}',
                          style: TextStyle(fontSize: 18, color: PrimaryColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          ': الساعه  ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${model.price}',
                          style: TextStyle(fontSize: 18, color: PrimaryColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          ': السعر  ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${model.price} LE',
                          style: TextStyle(fontSize: 18, color: PrimaryColor),
                        ),
                        Spacer(),
                        Text(
                          ': اجمالي السعر   ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChosePayment()));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChosePayment(
                              doctorName: doctorName,
                          userName: userName,
                          time:'${model.time}' ,
                          price: '${model.price}',
                          day: '${model.day}',
                          userId: userId,
                          doctorId: doctorId,

                            )));
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: PrimaryColor),
                child: Center(
                    child: Text(
                  'ادفع',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psychology_app/screens/layout/layout_screen.dart';

import '../model/booking_model.dart';
import '../widget/constant.dart';

class ConfirmBooking extends StatelessWidget {
  ConfirmBooking({
    Key? key,
    required this.doctorName,
    required this.userName,
    required this.price,
    required this.time,
    required this.day,
    required this.userId,
    required this.doctorId,
    required this.number

  }) : super(key: key);

  String doctorName;
  String doctorId;
  String userName;
  String userId;
  String day;
  String time;
  String price;
  String number;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        centerTitle: true,
        title: Text('تاكيد الحجز '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              Container(
                width: double.infinity,
                  height: 100,
                  child: Image.asset('images/vodafone2.png')),
              Container(
                alignment: Alignment.center,
                  child: Text('check out ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              SizedBox(
                height: 10,
              ),
              Text('رقم المحفظه ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$number',style: TextStyle(fontSize: 20,color: PrimaryColor,fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Text('المبلغ الكلي ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$price',style: TextStyle(fontSize: 20,color: PrimaryColor,fontWeight: FontWeight.bold),),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Text('الرقم السري للمحفظه ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText:'********'
                          ),
                        )
                    ),
                  ),
                ),
              ),


              SizedBox(
                height: 10,
              ),

              Text('OTP الرقم السري المتغير ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText:'********'
                    ),
                  )
                ),
              ),


              SizedBox(
                height: 40,
              ),

              GestureDetector(
                onTap: () {
                  pushDataToFirebase();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
                  // print('doctor name  '+doctorName);
                  // print('doctor id  '+doctorId);
                  // print('user name  '+userName);
                  // print('user id  '+userId);
                  // print('price  '+price);
                  // print('day  '+day);
                  // print('time  '+time);

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: PrimaryColor),
                  child: Center(
                      child: Text(
                    'pay with wallet',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void>pushDataToFirebase()async{
    try{
      final documentRef= firestore.collection('Bookings');
      final List<BookingModel> dataList =[
        BookingModel(
          userName: userName,
          userId: userId,
          doctorName: doctorName,
          doctorId: doctorId,
          day: day,
          price: price,
          time: time
        )
      ];
      for(final data in dataList){
        await documentRef.add(data.toMap());
      }
      print('Data pushed to Firestore document with UID:user id $userId and doctor id $doctorId ');
    }catch(e){
      print('Error pushing data to Firestore document: $e');
    }

  }


}

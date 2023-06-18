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
    required this.doctorId

  }) : super(key: key);

  String doctorName;
  String doctorId;
  String userName;
  String userId;
  String day;
  String time;
  String price;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  'تاكيد الدفع',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            ),
          ],
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

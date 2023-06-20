import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psychology_app/widget/constant.dart';

import '../model/booking_model.dart';
import '../screens/layout/layout_screen.dart';
class FawreyScreen extends StatelessWidget {

  FawreyScreen({
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
        title: Text('الدفع عن طريق فوري '),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Text('تاكيد الدفع عن طريق فوري ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 30,
                ),

                Text('المبلغ الكلي الذي سوف يتم تحويله ',style: TextStyle(fontSize: 18),),

                SizedBox(
                  height: 20  ,
                ),


                Text('$price LE ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),


                SizedBox(
                  height: 40  ,
                ),

                Text('تفاصيل الدفع',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 20,
                ),

                Container(
                  width: double.infinity,
                  height: 100,

                  decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Fawry plus  انتقل الي اقرب نقطه بيع ',style: TextStyle(color: Colors.white,fontSize: 18),),
                      Text('وادفع باستخدام رمز المعمله  ',style: TextStyle(color: Colors.white,fontSize: 15),),

                    ],
                  ),
                ),

                SizedBox(
                  height: 20  ,
                ),


                Text('كود معامله فوري ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                      alignment: Alignment.topRight,
                        child: Text('135557',style: TextStyle(fontSize: 20,color: PrimaryColor,fontWeight: FontWeight.bold),)),
                  ),
                ),

                SizedBox(
                  height: 20  ,
                ),


                Text('اسم التاجر  ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                        alignment: Alignment.topRight,
                        child: Text('Psychlogy App Securities',style: TextStyle(fontSize: 20,color: PrimaryColor,fontWeight: FontWeight.bold),)),
                  ),
                ),
                SizedBox(
                  height: 20  ,
                ),


                Text('رقم التاجر  ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                        alignment: Alignment.topRight,
                        child: Text('76402',style: TextStyle(fontSize: 20,color: PrimaryColor,fontWeight: FontWeight.bold),)),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Text(' تنتهي صلاحيه رمز معاملتك في غصون 24 ساعه ',style: TextStyle(fontSize: 12,color: Colors.red),),

                Text(' يرجي الاحتفاظ بصوره من ايصالك في حاله ارادنا تاكيد الدفع الخاص بك ',style: TextStyle(fontSize: 12,color: Colors.red),),

                SizedBox(
                  height: 40,
                ),

                GestureDetector(
                  onTap: (){
                    pushDataToFirebase();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,

                    decoration: BoxDecoration(
                        color: PrimaryColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text('تاكيد الدفع ',style: TextStyle(color: Colors.white,fontSize: 18),)),
                  ),
                )
              ],
            ),
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

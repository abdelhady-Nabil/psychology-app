import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/booking_model.dart';
import '../screens/layout/cubit/cubit.dart';
import '../screens/layout/cubit/states.dart';
import '../widget/constant.dart';
class BookingAdminScreen extends StatefulWidget {
  BookingAdminScreen({Key? key}) : super(key: key);

  @override
  State<BookingAdminScreen> createState() => _BookingAdminScreenState();
}

class _BookingAdminScreenState extends State<BookingAdminScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<BookingModel> bookingList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllBookings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit, PsychologyState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: PrimaryColor,
            centerTitle: true,
            title: Text('جميع الحجوزات'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
                itemBuilder: (context,index){
                  return buildItem(bookingList[index]);
                },
                separatorBuilder:  (context,index)=>SizedBox(height: 20,),
                itemCount: bookingList.length
            ),
          ),
        );
      },

    );
  }
  Widget buildItem(BookingModel model){
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),
      width: double.infinity,
      height: 200,
      child:  Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            //name
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text( '${model.userName}    ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),
                Text( ': اسم المريض ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),


              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text( 'Dr. ${model.doctorName}    ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),
                Text( ': اسم الدكتور ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),


              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( '${model.day}    ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: PrimaryColor),),
                    Spacer(),
                    Text( ': اليوم ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),


                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( '${model.time}    ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: PrimaryColor),),
                    Spacer(),
                    Text( ': الساعه ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),


                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( '${model.price}  L.E  ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: PrimaryColor),),
                    Spacer(),
                    Text( ': السعر ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),


                  ],
                ),



              ],
            ),

            //

          ],
        ),
      ),

    );

  }


  Future<void> getAllBookings() async {
    try {
      final querySnapshot = await firestore
          .collection('Bookings')
          .get();

      final bookings = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return BookingModel(
          userName: data['userName'],
          userId: data['userId'],
          doctorName: data['doctorName'],
          doctorId: data['doctorId'],
          day: data['day'],
          price: data['price'],
          time: data['time'],
        );
      }).toList();

      setState(() {
        bookingList = bookings;
      });
      print('Bookings retrieved successfully.');
    } catch (e) {
      print('Error retrieving bookings: $e');
      bookingList = [];
    }
  }
}

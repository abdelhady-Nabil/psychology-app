import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/booking_model.dart';
import '../screens/layout/cubit/cubit.dart';
import '../screens/layout/cubit/states.dart';
import '../widget/constant.dart';
class EarningAdminScreen extends StatefulWidget {
  EarningAdminScreen({Key? key}) : super(key: key);

  @override
  State<EarningAdminScreen> createState() => _EarningAdminScreenState();
}

class _EarningAdminScreenState extends State<EarningAdminScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<BookingModel> bookingList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingsByDoctorId();
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
            title: Text('Earning'),
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
      height: 250,
      child:  Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('Total Price  : ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text('${model.price}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),
              ],
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: PrimaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Total Earning for doctor : ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text('${int.parse(model.price)-int.parse(model.price)*0.2}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('Total Earning for application : ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text('${int.parse(model.price)*0.2}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('Patient name : ',style: TextStyle(fontSize: 15,),),
                Text('${model.userName}',style: TextStyle(fontSize: 15,color: PrimaryColor),),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('Doctor name : ',style: TextStyle(fontSize: 15,),),
                Text('${model.doctorName}',style: TextStyle(fontSize: 15,color: PrimaryColor),),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('the day of seacion : ',style: TextStyle(fontSize: 15,),),
                Text('${model.day}',style: TextStyle(fontSize: 15,color: PrimaryColor),),
              ],
            ),


          ],
        ),
      ),

    );

  }


  Future<void> getBookingsByDoctorId() async {
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

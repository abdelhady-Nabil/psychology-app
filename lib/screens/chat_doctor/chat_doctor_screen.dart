import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/model/doctor_model.dart';
import 'package:psychology_app/model/user_model.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/layout/cubit/states.dart';
import 'package:psychology_app/screens/layout/layout_screen.dart';
import 'package:psychology_app/screens/chat_doctor/chat_details_screen.dart';

import '../../model/booking_model.dart';
import '../../widget/constant.dart';
class ChatDoctorScreen extends StatefulWidget {
   ChatDoctorScreen({Key? key}) : super(key: key);

  @override
  State<ChatDoctorScreen> createState() => _ChatDoctorScreenState();
}

class _ChatDoctorScreenState extends State<ChatDoctorScreen> {
   final FirebaseFirestore firestore = FirebaseFirestore.instance;

   List<BookingModel> bookingList = [];

   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     getBookingsByUserId(uid);
   }

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit,PsychologyState>(
      listener: (context,state){},
      builder: (context,state){
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'تحدث مع طبيبك',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: 60,
                      ),

                      IconButton(onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>LayoutScreen()));
                      }, icon: Icon(Icons.arrow_forward))

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Expanded(
                    child: AnimatedConditionalBuilder(
                      condition: bookingList.length>0,
                      builder: (context)=> ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)=>buildChatItem(context,bookingList[index]),
                          separatorBuilder:(context,index)=> Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                          ),
                          itemCount:bookingList.length
                      ),
                      fallback: (context)=>Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Image.asset('images/no.png'),
                                Text(
                                  '! لا يوجد حجز حتي الان ',
                                  style: TextStyle(fontSize: 20, color: PrimaryColor),
                                ),
                                Text(
                                  '! احجز حتي تستطيع التحدث مع طبيب ',
                                  style: TextStyle(fontSize: 20, color: PrimaryColor),
                                ),
                                Spacer(),
                              ],
                            )),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },

    );
  }

  Widget buildChatItem(context,BookingModel model)=> InkWell(
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>ChatDetailsScreen(model: model)));
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 20.0,bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('images/dd.png'),
          ),
          SizedBox(
            width: 20,
          ),
          Text('Dr. ${model.doctorName}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ],
      ),
    ),
  );

   Future<void> getBookingsByUserId(String userId) async {
     try {
       final querySnapshot = await firestore
           .collection('Bookings')
           .where('userId', isEqualTo: userId)
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

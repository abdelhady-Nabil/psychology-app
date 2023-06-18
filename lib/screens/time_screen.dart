import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psychology_app/screens/layout/layout_screen.dart';
import 'package:psychology_app/widget/constant.dart';

import '../model/booking_model.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({Key? key}) : super(key: key);

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
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
    return SafeArea(
      child: Scaffold(
        body: bookingList.length == 0
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LayoutScreen()));
                            },
                            icon: Icon(Icons.arrow_forward))
                      ],
                    ),
                    Image.asset('images/no.png'),
                    Text(
                      '! لا يوجد حجز حتي الان ',
                      style: TextStyle(fontSize: 20, color: PrimaryColor),
                    ),
                    Spacer(),
                  ],
                )),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LayoutScreen()));
                            },
                            icon: Icon(Icons.arrow_forward))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return buildItem(bookingList[index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 20,
                              ),
                          itemCount: bookingList.length),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildItem(BookingModel model) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),
      width: double.infinity,
      height: 170,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            //name
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Dr. ${model.doctorName}    ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: PrimaryColor),
                ),
                Text(
                  ': اسم الدكتور ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
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
                    Text(
                      '${model.day}    ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: PrimaryColor),
                    ),
                    Spacer(),
                    Text(
                      ': اليوم ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${model.time}    ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: PrimaryColor),
                    ),
                    Spacer(),
                    Text(
                      ': الساعه ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${model.price}  L.E  ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: PrimaryColor),
                    ),
                    Spacer(),
                    Text(
                      ': السعر ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
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

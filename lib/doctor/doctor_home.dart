import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/doctor/add_new_time.dart';
import 'package:psychology_app/doctor/setting_doctor_screen.dart';
import 'package:psychology_app/doctor/video_call.dart';
import 'package:psychology_app/widget/constant.dart';

import '../admin/patient_screen.dart';
import '../auth/login/login_screen.dart';
import '../model/booking_model.dart';
import '../model/date_model.dart';
import '../screens/chat_user/chat_user_screen.dart';
import '../screens/layout/cubit/cubit.dart';
import '../screens/layout/cubit/states.dart';
import '../widget/custom_text.dart';
import 'all_date.dart';
import 'doctor_bookings.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}


class _DoctorHomeScreenState extends State<DoctorHomeScreen> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<BookingModel> bookingList = [];

  List<DateModel> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingsByDoctorId(uid);
    PsychologyCubit.get(context).getDoctorData();
    fetchData(uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit, PsychologyState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model =PsychologyCubit.get(context).doctorModel;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: PrimaryColor,
              title: Text('Dashboard'),
              actions: [
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      PsychologyCubit.get(context).signOut(context);
                      print('log out');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    icon: Icon(Icons.logout)),
              ],
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                children:  [
                  //header
                  Container(
                    color: PrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('images/dd.png'),
                            radius: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Dr ${model.name}',style: TextStyle(color: Colors.white),),
                          Text('${model.email}',style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      //PsychologyCubit.get(context).getUsers();

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllDate()));
                    },
                    title: Text('all Date'),
                    leading: Icon(Icons.schedule_outlined),
                  ),
                  ListTile(
                    onTap: (){
                      //PsychologyCubit.get(context).getUsers();

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatUserScreen()));
                    },
                    title: Text('chats'),
                    leading: Icon(Icons.chat),
                  ),
                  ListTile(
                    onTap: (){
                      PsychologyCubit.get(context).getUsers();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>VideoCall()));
                    },
                    title: Text('video cll'),
                    leading: Icon(Icons.video_call_outlined),
                  ),
                  ListTile(
                    title: Text('patient'),
                    leading: Icon(Icons.sick_outlined),
                    onTap: (){
                      PsychologyCubit.get(context).getUsers();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>PatientScreen()));

                    },
                  ),

                  ListTile(
                    onTap: (){
                      getBookingsByDoctorId(uid);
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>BookingDoctorScreen()));

                    },
                    title: Text('Booking'),
                    leading: Icon(Icons.local_activity_outlined),
                  ),
                  ListTile(
                    title: Text('Earning'),
                    leading: Icon(Icons.monetization_on_outlined),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingDoctorScreen()));
                    },
                    title: Text('Setting'),
                    leading: Icon(Icons.manage_accounts_outlined),
                  ),
                  ListTile(
                    onTap: (){
                      PsychologyCubit.get(context).signOut(context);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                    },
                    title: Text('log out'),
                    leading: Icon(Icons.logout),
                  ),


                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text('Welcome back'),
                              Text(
                                'Dr. ${model.name}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTime()));
                              }, icon: Icon(Icons.add_circle_outline_outlined)),
                              Text('add anew date')
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children:  [
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingDoctorScreen()));
                          },
                          child: CustomText(
                            text: 'عرض الكل',
                            fontSize: 12,
                            color: Colors.grey,

                          ),
                        ),
                        Spacer(),
                        CustomText(
                          text: 'الحجوزات',
                          fontSize: 18,
                          color:PrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    bookingList.length==0?
                    Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      child: Center(child: Text('! لا يوجد حجز حتي الان',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    )
                    : buildItem(bookingList[0]),

                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      children:  [
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AllDate()));
                          },
                          child: CustomText(
                            text: 'عرض الكل',
                            fontSize: 12,
                            color: Colors.grey,

                          ),
                        ),
                        Spacer(),
                        CustomText(
                          text: 'المواعيد',
                          fontSize: 18,
                          color:PrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),



                    dataList.length==0?
                    Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      child: Center(child: Text('! لا يوجد مواعيد حتي الان',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    )
                        : itemBuilder(context,dataList[0]),



                  ],
                ),
              ),
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
      height: 170,
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


  Future<void> getBookingsByDoctorId(String doctorId) async {
    try {
      final querySnapshot = await firestore
          .collection('Bookings')
          .where('doctorId', isEqualTo: doctorId)
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

  Widget itemBuilder(BuildContext context,DateModel model){


    return Dismissible(
        key:  UniqueKey(), // Generate a unique key for each item
        onDismissed: (direction){
          deleteItem(model);
        },
        background: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.delete_forever_outlined,color: Colors.white,),
              SizedBox(
                width: 16,
              ),

            ],
          ),
        ),
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300]
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios_new_outlined),
                  Spacer(),
                  Column(
                    children: [
                      Text('${model.day}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      Text('${model.time}  :  الساعه',style: TextStyle(fontSize: 12),),
                      Text('${model.price} LE :  السعر',style: TextStyle(fontSize: 12),)
                    ],
                  ),
                  SizedBox(width: 20,),
                  Icon(Icons.schedule_outlined,color: PrimaryColor,),




                ],
              ),
            ),

          ),
        )
    );
  }


  Future <void> fetchData(String uid)async{
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid)
        .collection('dateList')
        .get()
        .then((querySnapShot){
      List<DateModel>fetchDataList=[];
      querySnapShot.docs.forEach((doc) {
        Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
        DateModel model =DateModel.fromJson(data);

        fetchDataList.add(model);
      });

      setState(() {
        dataList=fetchDataList;
      });


    }).catchError((error){
      print("Error fetching data: $error");
    });


  }

  Future<void> deleteItem(DateModel model) async {
    try {
      // Delete the item from Firestore
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(uid)
          .collection('dateList')
          .where('day', isEqualTo: model.day) // Use a suitable field to identify the item for deletion
          .where('time', isEqualTo: model.time)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

      // Remove the item from the list
      setState(() {
        dataList.remove(model);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item deleted successfully')),
      );
    } catch (error) {
      print('Error deleting item: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item')),
      );
    }
  }





}

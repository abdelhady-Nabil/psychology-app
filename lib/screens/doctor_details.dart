import 'package:flutter/material.dart';

import '../booking/booking_screen.dart';
import '../model/doctor_model.dart';
import '../widget/constant.dart';
import 'layout/layout_screen.dart';

class DoctorDetails extends StatelessWidget {
   DoctorDetails({Key? key,required this.model}) : super(key: key);

   DoctorModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[10],
                borderRadius: BorderRadius.circular(40)
            ),

            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_forward))
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: PrimaryColor,
                            backgroundImage: AssetImage('images/dd.png'),
                            radius: 60,
                          ),
                          Text('Dr. ${model.name}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          Text('طبيب نفسي',style: TextStyle(fontSize: 20,color: Colors.grey),),
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                              alignment: Alignment.topRight,
                              child: Text('الانجازات',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),

                          Container(
                            width: double.infinity,
                            height: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Image.asset('images/aa.png'),
                                          width: 100,
                                          height: 100,
                                        ),
                                        Text('120+',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                        Text('مريض'),

                                      ],

                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Image.asset('images/bb.png'),
                                          width: 100,
                                          height: 100,
                                        ),
                                        Text('5+',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                        Text('الخبره'),

                                      ],

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),



                          Container(
                            width: double.infinity,
                            height: 50,

                            decoration: BoxDecoration(
                                color: PrimaryColor,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: TextButton(onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>BookingScreen(name:model.name,doctorid: model.doctorId,)));
                            }, child:Text('احجز الان',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

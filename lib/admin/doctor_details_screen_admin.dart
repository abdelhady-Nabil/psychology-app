import 'package:flutter/material.dart';

import '../booking/booking_screen.dart';
import '../model/doctor_model.dart';
import '../model/user_model.dart';
import '../widget/constant.dart';

class DoctorDetailsScreenAdmin extends StatelessWidget {
  DoctorDetailsScreenAdmin({Key? key,required this.model}) : super(key: key);

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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: PrimaryColor,
                            backgroundImage: AssetImage('images/dd.png'),
                            radius: 60,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('Doctor name  :  ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                              Text('${model.name}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: PrimaryColor),),
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('Doctor Email  :  ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                              Text('${model.email}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: PrimaryColor),),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Text('Doctor Phone  :  ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                              Text('${model.phone}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: PrimaryColor),),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),



                          Row(
                            children: [
                              Text('Doctor password  :  ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                              Text('${model.password}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: PrimaryColor),),
                            ],
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


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/model/doctor_model.dart';
import 'package:psychology_app/model/message_model.dart';
import 'package:psychology_app/model/user_model.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/layout/cubit/states.dart';
import 'package:psychology_app/widget/constant.dart';

import '../../model/booking_model.dart';
class ChatDetailsScreen extends StatelessWidget {


  late BookingModel model ;
  ChatDetailsScreen({super.key, required this.model});

  final messageTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Builder( //acsess on message befor consumer start
      builder: (BuildContext context){
        //PsychologyCubit psychologyCubit = PsychologyCubit();
        PsychologyCubit.get(context).getDoctors();
        PsychologyCubit.get(context).getMessages(
            receiverId: model.doctorId,
          senderId: model.userId
        );

        return BlocConsumer<PsychologyCubit,PsychologyState>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                titleSpacing: 0,

                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('images/dd.png'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Dr. ${model.doctorName}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                    //Text('${model.doctorId}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),

                  ],
                ),
                actions: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_forward,color: Colors.black,))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(

                  children: [
                   // Text('${int.parse(model.time.toString().substring(0,1))+1}'),
                   Expanded(
                     child: ListView.separated(
                         itemBuilder: (context,index){
                           var message = PsychologyCubit.get(context).messages[index];
                           if(model.userId == message.senderId){
                             return buildMyMessage(message);
                           }else{
                             return buildMessage(message);
                           }

                         },
                         separatorBuilder: (context,state)=>SizedBox(
                           height: 15,
                         ),
                         itemCount: PsychologyCubit.get(context).messages.length
                     ),
                   ),
                    //Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TextField(
                              controller: messageTextController,
                              onChanged: (value){
                                //massageText = value;
                              },

                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                hintText: 'Enter your massage here',
                                border: InputBorder.none,
                              ),

                            )
                        ),
                        TextButton(
                            onPressed: (){
                              //messageTextController.clear();
                              PsychologyCubit.get(context).sendMessage(
                                senderId: uid,
                                  receiverId: model.doctorId,
                                  dateTime: DateTime.now().toString(),
                                  text: messageTextController.text
                              );
                              messageTextController.clear();
                            },
                            child: const Text('Send',style:TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ) ,)
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            );
          },
        );
      },

    );
  }

  Widget buildMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Material(
        elevation: 10,
        borderRadius:BorderRadius.only(
          topLeft: Radius.circular(30),
          //bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(model.text,style: TextStyle(color: Colors.white,fontSize: 15),),
        )
    ),
  );
  Widget buildMyMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Material(
        elevation: 10,
        borderRadius:BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          //bottomRight: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: PrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(model.text,style: TextStyle(color: Colors.white,fontSize: 15),),
        )
    ),
  );
}

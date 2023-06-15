
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/auth/login/cubit/states.dart';
import 'package:psychology_app/auth/login/login_screen.dart';
import 'package:psychology_app/model/message_model.dart';
import 'package:psychology_app/model/user_model.dart';
import 'package:psychology_app/screens/layout/cubit/states.dart';
import 'package:psychology_app/shared/cache_helper.dart';

import '../../../model/doctor_model.dart';
import '../../../widget/constant.dart';
import '../../call/start_call.dart';
import '../../chat_doctor/chat_doctor_screen.dart';
import '../../home_screen.dart';
import '../../measure/measure_screen.dart';
import '../../more_screen.dart';
import '../../time_screen.dart';

class PsychologyCubit extends Cubit<PsychologyState>{

  PsychologyCubit() : super(PsychologyInitialState());

  static PsychologyCubit get(context) =>BlocProvider.of(context);

  int index = 5;
  List<Widget>screens=[
    MoreScreen(),
    MeasureScreen(),
    TimeScreen(),
    StartCall(),
    ChatDoctorScreen(),
    HomeScreen(),
  ];

  //indecator progress
  bool showSpinner = false;
  late UserModel model;
  void getUserData(){
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value){
          //print(value.data()); // is map
         //take map
          //print(uid);
          //print('ddddddddddddddd');
          //print('${value.id}');
          //uid=value.id;
          model=UserModel.fromJson(value.data()!);
          emit(GetUserSuccessState());
    }).catchError((error){
          print(error.toString());
          emit(GetUserErrorState());
    });

  }

  late DoctorModel doctorModel;
  void getDoctorData(){
    emit(GetDoctorLoadingState());
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid)
        .get()
        .then((value){
      //print(value.data()); // is map
      //take map
      //print(uid);
      //print('ddddddddddddddd');
      //print('${value.id}');
      //uid=value.id;
      doctorModel=DoctorModel.fromJson(value.data()!);
      emit(GetDoctorSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetDoctorErrorState());
    });

  }

  List<UserModel> users =[];

  void getUsers() {
    //get doctor if you change the collection
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get()
          .then((value) {
        value.docs.forEach((element) {
          users.add(UserModel.fromJson(element.data()));
        });
        emit(GetAllUserSuccessState());
      }).catchError((error) {
        emit(GetAllUserErrorState());
      });
    }
  }


  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
}){
    MessageModel modelMessage = MessageModel(
        senderId: model.userId, //me
        receiverId: receiverId,
        text: text,
        dateTime: dateTime);

    //from me to another
    FirebaseFirestore.instance
    .collection('users')
    .doc(model.userId)//me
    .collection('chats')
    .doc(receiverId) //with
    .collection('messages') //messages
    .add(modelMessage.toMap()) //add message
    .then((value){
      emit(SendMessageSuccessState());
    })
    .catchError((error){
      emit(SendMessageErrorState());
    });

    //from another to me
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(receiverId)//with
        .collection('chats')
        .doc(doctorModel.doctorId) //me
        .collection('messages') //messages
        .add(modelMessage.toMap()) //add message
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });

  }

  List<MessageModel> messages =[];

  void getMessages({
  required String receiverId
}) {

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.userId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots() //return stream of query
        .listen((event) {  //event is messages

          messages = []; //zeros list
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(GetMessageSuccessState());

    });

    FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorModel.doctorId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots() //return stream of query
        .listen((event) {  //event is messages
      messages = []; //zeros list
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));

      });

      emit(GetMessageSuccessState());

    });

  }


  List<DoctorModel> doctors =[];

  void getDoctors() {
    //get doctor if you change the collection
    if (doctors.length == 0) {
      FirebaseFirestore.instance.collection('doctors').get()
          .then((value) {
        value.docs.forEach((element) {
          doctors.add(DoctorModel.fromJson(element.data()));
        });
        emit(GetAllDoctorSuccessState());
      }).catchError((error) {
        emit(GetAllDoctorErrorState());
      });
    }
  }

  void signOut(context){
    CacheHelper.removeDate(key:'userId')
        .then((value){
          if(value){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
          }
    });



  }


}
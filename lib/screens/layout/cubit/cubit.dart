
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/auth/login/cubit/states.dart';
import 'package:psychology_app/model/message_model.dart';
import 'package:psychology_app/model/user_model.dart';
import 'package:psychology_app/screens/layout/cubit/states.dart';

import '../../../widget/constant.dart';

class PsychologyCubit extends Cubit<PsychologyState>{

  PsychologyCubit() : super(PsychologyInitialState());

  static PsychologyCubit get(context) =>BlocProvider.of(context);
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
          //print(value.data()!); // is map
         //take map
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

  List<UserModel> users =[];


  void getUsers() {
    //get doctor if you change the collection
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get()
          .then((value) {
        value.docs.forEach((element) {
          if(element.data()['uid'] != model.userId) {
            users.add(UserModel.fromJson(element.data()));
          }
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
        .collection('users')
        .doc(receiverId)//with
        .collection('chats')
        .doc(model.userId) //me
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
  }

}
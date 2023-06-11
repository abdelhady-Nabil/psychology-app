import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{

  late String senderId;
  late String receiverId;
 late String dateTime;
  late String text;


  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.dateTime,

  });

  MessageModel.fromJson(Map<dynamic,dynamic>map){
    if(map == null){
      return;
    }
    senderId = map['senderId'];  //map['userId'] data get from fire store
    receiverId = map['receiverId'];
    text=map['text'];
    dateTime=map['dateTime'];
  }


  //anther form
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['num1'] = this.num1;
  //   data['num2'] = this.num2;
  //   return data;
  // }

  toMap(){
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text' : text,
      'dateTime':dateTime,
    };
  }





}
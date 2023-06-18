import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel{

  late String doctorName;
  late String doctorId;
  late String userName;
  late String userId;
  late String day;
  late String time;
  late String price;


  BookingModel({
    required this.doctorId,
    required this.userId,
    required this.time,
    required this.price,
    required this.userName,
    required this.doctorName,
    required this.day
  });

  BookingModel.fromJson(Map<dynamic,dynamic>map){
    if(map == null){
      return;
    }
    doctorId = map['doctorId'];  //map['userId'] data get from fire store
    userName = map['userName'];
    doctorName = map['doctorName'];
    day = map['day'];
    userId = map['userId'];
    time=map['time'];
    price=map['price'];
  }

  toMap(){
    return {
      'doctorId': doctorId,
      'userName': userName,
      'doctorName' : doctorName,
      'day':day,
      'userId':userId,
      'time':time,
      'price':price,
    };
  }





}
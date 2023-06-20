
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/auth/login/cubit/states.dart';
import 'package:psychology_app/auth/login/login_screen.dart';
import 'package:psychology_app/model/booking_model.dart';
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

  List<BookingModel> bookings =[];
  
  void getBookings() {
    emit(GetBookingsLoadingState());
    if (bookings.length == 0) {
      FirebaseFirestore.instance.collection('Bookings').get()
          .then((value) {
        value.docs.forEach((element) {
          bookings.add(BookingModel.fromJson(element.data()));
        });
        emit(GetBookingsSuccessState());
      }).catchError((error) {
        emit(GetBookingsErrorState());
      });
    }
  }


  void sendMessage({ //to doctor
    required String senderId, //user_id
    required String receiverId,//doctor_id
    required String dateTime,
    required String text,
}){
    MessageModel modelMessage = MessageModel(
        senderId: senderId, //user
        receiverId: receiverId, //doctor
        text: text,
        dateTime: dateTime);

    //from users to doctor
    FirebaseFirestore.instance
    .collection('users')
    .doc(senderId)//user
    .collection('chats')
    .doc(receiverId) //doctor
    .collection('messages') //messages
    .add(modelMessage.toMap()) //add message
    .then((value){
      emit(SendMessageSuccessState());
    })
    .catchError((error){
      emit(SendMessageErrorState());
    });

    //from doctor to user
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(receiverId)//doctor
        .collection('chats')
        .doc(senderId) //user
        .collection('messages') //messages
        .add(modelMessage.toMap()) //add message
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    }
    );

  }


  void sendMessageToUser({ //to user
    required String senderId, //doctor_id
    required String receiverId,//user_id
    required String dateTime,
    required String text,
  }){
    MessageModel modelMessage = MessageModel(
        senderId: senderId, //doctor
        receiverId: receiverId, //user
        text: text,
        dateTime: dateTime);

    //from users to doctor
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)//user
        .collection('chats')
        .doc(senderId) //doctor
        .collection('messages') //messages
        .add(modelMessage.toMap()) //add message
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });

    //from doctor to user
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(senderId)//doctor
        .collection('chats')
        .doc(receiverId) //user
        .collection('messages') //messages
        .add(modelMessage.toMap()) //add message
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    }
    );

  }

  List<MessageModel> messages =[];

  void getMessages({
  required String receiverId,
    required String senderId

}) {


    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverId) //doctors
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


  List<DoctorModel> chatDoctors =[];

  void getChatDoctors(UserModel user,DoctorModel doctor) async{
    //get doctor if you change the collection

    CollectionReference bookingsCollection =
    FirebaseFirestore.instance.collection('Bookings');

    Query bookingsQuery = bookingsCollection
        .where('doctorId', isEqualTo: doctor.doctorId)
        .where('userId', isEqualTo: user.userId);

    QuerySnapshot querySnapshot = await bookingsQuery.get();
    querySnapshot.docs.forEach((bookingDoc) {
      // Access the booking data
      var bookingData = bookingDoc.data();

      if (chatDoctors.length == 0) {
        FirebaseFirestore.instance.collection('doctors').get()
            .then((value) {
          value.docs.forEach((element) {
            chatDoctors.add(DoctorModel.fromJson(element.data()));
          });
          print('list chat doctor success ');
          //emit(GetAllDoctorSuccessState());
        }).catchError((error) {
          //emit(GetAllDoctorErrorState());
          print('list chat doctor error ');
        });
      }

      // Process the booking data as needed
      print('Booking details: $bookingData');
    });



  }

  CollectionReference bookingsCollection = FirebaseFirestore.instance.collection('Bookings');

  int totalPrice = 0;

  Future<int> getTotalPrice() async {

    print('getTotla price loading');
    int totalPrice = 0;

    QuerySnapshot querySnapshot = await bookingsCollection.get();
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('price')) {
        String? priceString = data['price'];
        if (priceString != null) {
          int price = int.tryParse(priceString) ?? 0;
          totalPrice += price;
        }
      }
    });

    print('success getTotalPrice$totalPrice');

    return totalPrice;
  }


  // File? profileImage;
  //
  // var picker = ImagePicker();
  // Future<void> getImage()async{
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if(pickedFile!= null){
  //     profileImage=File(pickedFile.path);
  //     emit(ProfileImagePickedSuccessState());
  //   }else{
  //     print('no profileImage selected');
  //     emit(ProfileImagePickedErrorState());
  //   }
  //
  // }

}
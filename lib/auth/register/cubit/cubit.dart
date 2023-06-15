import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/auth/register/cubit/states.dart';

import '../../../model/user_model.dart';

class RegisterCubit extends Cubit<RegisterState>{

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) =>BlocProvider.of(context);


  //indecator progress
  bool showSpinner = false;

  void playSpinner(){
    showSpinner=true;
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
}){
    emit(RegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      userCreate(
        uid: value.user!.uid,
        name: name, //جي بعد كده
        email: email,
        phone: phone,
        password: password
      );
      emit(RegisterSuccessState());
    }).catchError((error){
      emit(RegisterErrorState());
    });

  }

  //use it in userRegister above
  void userCreate({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uid
  }){
    UserModel model = UserModel(
      name: name,
      email: email,
      password: password,
      phone: phone,
      userId: uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value){ //خلاص خلصت
          emit(CreateUserSuccessState());
    }).catchError((error){
          emit(CreateUserErrorState());
    });

  }





}
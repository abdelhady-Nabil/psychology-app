import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/admin/cubit/states.dart';
import 'package:psychology_app/auth/register/cubit/states.dart';

import '../../../model/doctor_model.dart';

class RegisterDoctorCubit extends Cubit<RegisterDoctorState>{

  RegisterDoctorCubit() : super(RegisterDoctorInitialState());

  static RegisterDoctorCubit get(context) =>BlocProvider.of(context);


  //indecator progress
  bool showSpinner = false;

  void RegisterDoctor({
    required String name,
    required String email,
    required String password,
    required String phone,
}){
    emit(RegisterDoctorLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      doctorCreate(
        uid: value.user!.uid,
        name: name, //جي بعد كده
        email: email,
        phone: phone,
        password: password
      );
          emit(RegisterDoctorSuccessState());
    }).catchError((error){
      emit(RegisterDoctorErrorState());
    });

  }

  //use it in doctorRegisterDoctor above
  void doctorCreate({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uid
  }){
    DoctorModel model = DoctorModel(
      name: name,
      email: email,
      password: password,
      phone: phone,
      doctorId: uid,
    );
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid)
        .set(model.toMap())
        .then((value){ //خلاص خلصت
          emit(CreateDoctorSuccessState());
    }).catchError((error){
          emit(CreateDoctorErrorState());
    });

  }




}
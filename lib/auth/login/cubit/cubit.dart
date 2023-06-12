
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/auth/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginState>{

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) =>BlocProvider.of(context);


  //indecator progress
  bool showSpinner = false;

  void playSpinner(){
    showSpinner=true;
  }

  void userLogin({
  required String email,
    required String password
}){
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState());
    });


  }

  // void AdminLogin({
  //   required String email,
  //   required String password
  // }){
  //   emit(LoginLoadingState());
  //
  //   FirebaseFirestore.instance.collection('admin').doc('adminLogin').snapshots().forEach((element) {
  //     if(element.data()?['adminEmail'] == email && element.data()?['adminPassword']==password){
  //
  //     }
  //   });
  //
  //   // FirebaseAuth.instance.signInWithEmailAndPassword(
  //   //     email: email,
  //   //     password: password
  //   // ).then((value){
  //   //   emit(LoginSuccessState(value.user!.uid));
  //   // }).catchError((error){
  //   //   emit(LoginErrorState());
  //   // });
  //
  //
  // }





}
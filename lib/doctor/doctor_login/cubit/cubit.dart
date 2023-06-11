
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/auth/login/cubit/states.dart';
import 'package:psychology_app/doctor/doctor_login/cubit/states.dart';

class LoginDoctorCubit extends Cubit<LoginDoctorState>{

  LoginDoctorCubit() : super(LoginDoctorInitialState());

  static LoginDoctorCubit get(context) =>BlocProvider.of(context);


  //indecator progress
  bool showSpinner = false;

  void userLoginDoctor({
  required String email,
    required String password
}){
    emit(LoginDoctorLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      emit(LoginDoctorSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginDoctorErrorState());
    });


  }





}
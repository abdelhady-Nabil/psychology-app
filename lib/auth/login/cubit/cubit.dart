
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/auth/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginState>{

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) =>BlocProvider.of(context);


  //indecator progress
  bool showSpinner = false;

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





}
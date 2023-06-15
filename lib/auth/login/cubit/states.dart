abstract class LoginState{}

class LoginInitialState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
  final String uid;
  LoginSuccessState(this.uid);
}
class LoginErrorState extends LoginState{}




class LoginDoctorInitialState extends LoginState{}
class LoginDoctorLoadingState extends LoginState{}
class LoginDoctorSuccessState extends LoginState{
  final String uid;
  LoginDoctorSuccessState(this.uid);
}
class LoginDoctorErrorState extends LoginState{}


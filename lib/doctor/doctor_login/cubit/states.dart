abstract class LoginDoctorState{}

class LoginDoctorInitialState extends LoginDoctorState{}
class LoginDoctorLoadingState extends LoginDoctorState{}
class LoginDoctorSuccessState extends LoginDoctorState{
  final String uid;
  LoginDoctorSuccessState(this.uid);
}
class LoginDoctorErrorState extends LoginDoctorState{}


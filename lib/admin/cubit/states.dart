abstract class RegisterDoctorState{}

class RegisterDoctorInitialState extends RegisterDoctorState{}
class RegisterDoctorLoadingState extends RegisterDoctorState{}
class RegisterDoctorSuccessState extends RegisterDoctorState{}
class RegisterDoctorErrorState extends RegisterDoctorState{}

class CreateDoctorSuccessState extends RegisterDoctorState{}
class CreateDoctorErrorState extends RegisterDoctorState{}



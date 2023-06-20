abstract class PsychologyState{}

class PsychologyInitialState extends PsychologyState{}


class GetUserLoadingState extends PsychologyState{}
class GetUserSuccessState extends PsychologyState{}
class GetUserErrorState extends PsychologyState{}

class GetDoctorLoadingState extends PsychologyState{}
class GetDoctorSuccessState extends PsychologyState{}
class GetDoctorErrorState extends PsychologyState{}

class GetAllUserLoadingState extends PsychologyState{}
class GetAllUserSuccessState extends PsychologyState{}
class GetAllUserErrorState extends PsychologyState{}

class GetAllDoctorLoadingState extends PsychologyState{}
class GetAllDoctorSuccessState extends PsychologyState{}
class GetAllDoctorErrorState extends PsychologyState{}


class SendMessageSuccessState extends PsychologyState{}
class SendMessageErrorState extends PsychologyState{}

class GetMessageSuccessState extends PsychologyState{}
class GetMessageErrorState extends PsychologyState{}


class GetBookingsLoadingState extends PsychologyState{}
class GetBookingsSuccessState extends PsychologyState{}
class GetBookingsErrorState extends PsychologyState{}


class ProfileImagePickedSuccessState extends PsychologyState{}
class ProfileImagePickedErrorState extends PsychologyState{}

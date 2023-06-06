abstract class RegisterState{}

class RegisterInitialState extends RegisterState{}
class RegisterLoadingState extends RegisterState{}
class RegisterSuccessState extends RegisterState{}
class RegisterErrorState extends RegisterState{}

class CreateUserSuccessState extends RegisterState{}
class CreateUserErrorState extends RegisterState{}


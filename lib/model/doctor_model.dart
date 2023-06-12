class DoctorModel{

  late var doctorId, name, email, password, phone;

  DoctorModel({
    required this.doctorId,
    required this.name,
    required this.email,
    required this.password,
    required this.phone
  });

  DoctorModel.fromJson(Map<dynamic,dynamic>map){
    if(map == null){
      return;
    }
    doctorId = map['doctorId'];  //map['doctorId'] data get from fire store
    name = map['name'];
    email=map['emil'];
    phone=map['phone'];
    password=map['password'];
  }


  //anther form
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['num1'] = this.num1;
  //   data['num2'] = this.num2;
  //   return data;
  // }

  toMap(){
    return {
      'doctorId': doctorId,
      'name': name,
      'emil' : email,
      'phone':phone,
      'password':password,
    };
  }





}
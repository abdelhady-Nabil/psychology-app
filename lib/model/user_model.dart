class UserModel{

   late var userId, name, email, password, phone;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.phone
  });

  UserModel.fromJson(Map<dynamic,dynamic>map){
    if(map == null){
      return;
    }
    userId = map['userId'];  //map['userId'] data get from fire store
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
      'userId': userId,
       'name': name,
       'emil' : email,
       'phone':phone,
       'password':password,
    };
  }





}
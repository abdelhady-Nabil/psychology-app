class DateModel{

  late var day, time, price;

  DateModel({
    required this.day,
    required this.time,
    required this.price,
  });

  DateModel.fromJson(Map<dynamic,dynamic>map){
    if(map == null){
      return;
    }
    day = map['day'];  //map['userId'] data get from fire store
    time = map['time'];
    price=map['price'];
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
      'day': day,
      'time': time,
      'price' : price,
    };
  }





}
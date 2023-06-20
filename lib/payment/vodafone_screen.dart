import 'package:flutter/material.dart';

import '../booking/confirm_booking.dart';
import '../widget/constant.dart';
class VodafoneScreen extends StatelessWidget {


   VodafoneScreen({
     Key? key,
     required this.doctorName,
     required this.userName,
     required this.price,
     required this.time,
     required this.day,
     required this.userId,
     required this.doctorId

   }) : super(key: key);

   String doctorName;
   String doctorId;
   String userName;
   String userId;
   String day;
   String time;
   String price;




  final TextEditingController  _phoneEmailController = TextEditingController();

   final _formKey = GlobalKey<FormState>();


   @override
  Widget build(BuildContext context) {
    return Form(
      key:_formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          centerTitle: true,
          title: Text('الدفع عن طريق فودافون كاش'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('ادخل رقم هاتف المحفظه ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('برجاء ادخال رقم هاتف المحفظه الخاصه بك '),

                    SizedBox(
                      height: 30  ,
                    ),

                    TextFormField(
                      decoration: const InputDecoration(
                        label:Text('ادخل رقم التليفون ',style: TextStyle(color: PrimaryColor),),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PrimaryColor)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PrimaryColor)
                        ),
                        // border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone,color: PrimaryColor,),
                        prefixText: '+2',
                      ),
                      maxLength: 11,

                      cursorColor: PrimaryColor,
                      controller:_phoneEmailController ,
                      validator: (value){
                        if(value!.isEmpty){
                          return "ادخل رقم التليفون";
                        }
                        if(value.length < 11){
                          return "ادخلت رقم تليفون غلط";
                        }
                        return null;
                      },
                      onChanged: (value){
                        value = _phoneEmailController.text;
                      },
                    ),

                    SizedBox(
                      height: 30  ,
                    ),

                    Text('المبلغ الكلي الذي سوف يتم تحويله ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                    SizedBox(
                      height: 20  ,
                    ),


                    Text('$price LE ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),

                    SizedBox(
                      height: 40  ,
                    ),

                    Container(
                      width: double.infinity,
                      height: 100,

                      decoration: BoxDecoration(
                          color: PrimaryColor,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ملاحظه : ستتم اعاده توجيهك الي صفحه التاكيد لادخال ',style: TextStyle(color: Colors.white,fontSize: 15),),
                          Text('كلمه مرور محفظتك وكلمه مرور OTP ',style: TextStyle(color: Colors.white,fontSize: 15),),

                        ],
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    GestureDetector(
                      onTap: (){

                        if(_formKey.currentState!.validate()){

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmBooking(
                                    doctorName: doctorName,
                                    userName: userName,
                                    time:time ,
                                    price: price,
                                    day: day,
                                    userId: userId,
                                    doctorId: doctorId,
                                    number: _phoneEmailController.text,

                                  )));
                        }

                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,

                        decoration: BoxDecoration(
                            color: PrimaryColor,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(child: Text('انتقال الي الدفع ',style: TextStyle(color: Colors.white,fontSize: 18),)),
                      ),
                    ),











                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

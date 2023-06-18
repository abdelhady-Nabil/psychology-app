import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/widget/constant.dart';

import '../model/date_model.dart';
import '../screens/layout/cubit/cubit.dart';
import '../screens/layout/cubit/states.dart';
import '../screens/layout/layout_screen.dart';
import 'booking_details.dart';

class BookingScreen extends StatefulWidget {
  String name;
  String doctorid;

   BookingScreen({Key? key,this.name='',this.doctorid=''}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<DateModel> dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData('${widget.doctorid}');
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit,PsychologyState>(
      listener: (context,state){},
      builder: (context,state){
        return SafeArea(
          child: Scaffold(

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text( 'المواعيد المتاحه لدكتور',style: TextStyle(fontSize: 18),),
                                Text( '${widget.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),
                                // Text( '${PsychologyCubit.get(context).model.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),
                                // Text( '${PsychologyCubit.get(context).model.userId}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor),),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),

                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));

                          }, icon:Icon(Icons.arrow_forward)),

                        ],
                      )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context,index)=>itemBuilder(context,dataList[index],'${widget.name}','${PsychologyCubit.get(context).model.name}','${PsychologyCubit.get(context).model.userId}','${widget.doctorid}'),
                        separatorBuilder: (context,index)=>Container(
                          width: double.infinity,
                          height: 1,
                          color: PrimaryColor,
                        ),
                        itemCount: dataList.length
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }

  Widget itemBuilder(BuildContext context,DateModel model,String doctorName,String userName,String userId,String doctorId){

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>BookingDetails(model: model,doctorName:doctorName,userId: userId,userName: userName,doctorId: doctorId,)));
        },
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300]
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_outlined),
                Spacer(),
                Column(
                  children: [
                    Text('${model.day}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    Text('${model.time}  :  الساعه',style: TextStyle(fontSize: 12),),
                    Text('${model.price} LE :  السعر',style: TextStyle(fontSize: 12),)
                  ],
                ),
                SizedBox(width: 20,),
                Icon(Icons.schedule_outlined,color: PrimaryColor,),




              ],
            ),
          ),

        ),
      ),
    );
  }


  Future <void> fetchData(String uid)async{
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid)
        .collection('dateList')
        .get()
        .then((querySnapShot){
      List<DateModel>fetchDataList=[];
      querySnapShot.docs.forEach((doc) {
        Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
        DateModel model =DateModel.fromJson(data);

        fetchDataList.add(model);
      });

      setState(() {
        dataList=fetchDataList;
      });


    }).catchError((error){
      print("Error fetching data: $error");
    });


  }


}

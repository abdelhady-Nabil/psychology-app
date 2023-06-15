import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psychology_app/widget/constant.dart';

import '../model/date_model.dart';
class AllDate extends StatefulWidget {
   AllDate({Key? key}) : super(key: key);

  @override
  State<AllDate> createState() => _AllDateState();
}

class _AllDateState extends State<AllDate> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<DateModel> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(uid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: const Text('All Date'),
      ),
      body: ListView.separated(
          itemBuilder: (context,index)=>itemBuilder(context,dataList[index]),
          separatorBuilder: (context,index)=>Container(
            width: double.infinity,
            height: 1,
            color: PrimaryColor,
          ),
          itemCount: dataList.length
      ),
    );
  }

 Widget itemBuilder(BuildContext context,DateModel model){


    return Padding(
      padding: const EdgeInsets.all(20.0),
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

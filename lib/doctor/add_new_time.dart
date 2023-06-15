import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psychology_app/widget/constant.dart';

import '../model/date_model.dart';

class AddNewTime extends StatefulWidget {
  const AddNewTime({Key? key}) : super(key: key);

  @override
  State<AddNewTime> createState() => _AddNewTimeState();
}

class _AddNewTimeState extends State<AddNewTime> {
  static List<String> list = <String>['السبت', 'الأحد', 'الإثنين', 'الثلاثاء','الأربعاء','الخميس','الجمعة'];
  String dropdownValue = list.first;

  static List<String> listOfPrice = <String>['50', '100', '150', '200','250','300','350'];
  String price = listOfPrice.first;


  TimeOfDay selectTime = TimeOfDay.now();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: const Text('Add anew Date'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'pick day',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    const Text('day :',style: TextStyle(fontSize: 18),),
                   const  SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      value: dropdownValue,
                      //icon: const Icon(Icons.arrow_downward),
                      //elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ))

                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Time',
                  style: TextStyle(fontSize: 20),
                ),
                 Container(
                   alignment: Alignment.center,
                   child: Text(
                    '${selectTime.hour} : ${selectTime.minute}',
                    style: TextStyle(fontSize: 20,color: PrimaryColor),
                ),
                 ),
                GestureDetector(
                  onTap: ()async{
                    final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: selectTime,
                      initialEntryMode: TimePickerEntryMode.dial
                    );
                    if(timeOfDay!=null){
                      setState(() {
                        selectTime=timeOfDay;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: PrimaryColor,
                    ),
                    child: const Center(child: Text('Pick Time',style: TextStyle(color: Colors.white,fontSize: 18),)),

                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'pick Price',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    const Text('price :',style: TextStyle(fontSize: 18),),
                    const  SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                          value: price,
                          //icon: const Icon(Icons.arrow_downward),
                          //elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              price = value!;
                            });
                          },
                          items:listOfPrice.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ))

                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300]
                  ),

                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text( '$dropdownValue ',style: TextStyle(fontSize: 20,color: PrimaryColor),),
                            Text( ': اليوم ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),


                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text( '${selectTime.hour}:${selectTime.minute}',style: TextStyle(fontSize: 20,color: PrimaryColor),),
                            Text( ': الساعه ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),


                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text( '$price',style: TextStyle(fontSize: 20,color: PrimaryColor),),
                            Text( ': السعر   ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),


                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          pushDataToFirebase();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: PrimaryColor,
                          ),
                          child: const Center(child: Text('save',style: TextStyle(color: Colors.white,fontSize: 18),)),

                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                          child: const Center(child: Text('cancel',style: TextStyle(color: Colors.white,fontSize: 18),)),

                        ),
                      ),
                    ),
                  ],
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void>pushDataToFirebase()async{
    try{
      final documentRef= firestore.collection('doctors').doc(uid);
      //final List<String> dataList = ['$dropdownValue', '${selectTime.hour}:${selectTime.minute}' , '$price'];

      final List<DateModel> dataList =[
        DateModel(day: '$dropdownValue', time: '${selectTime.hour}:${selectTime.minute}', price:'$price')
      ];
      for(final data in dataList){
        await documentRef.collection('dateList').add(data.toMap());
      }

      print('Data pushed to Firestore document with UID: $uid');
    }catch(e){
      print('Error pushing data to Firestore document: $e');
    }
    
  }
}

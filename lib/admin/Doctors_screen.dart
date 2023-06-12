import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/doctor_model.dart';
import '../screens/layout/cubit/cubit.dart';
import '../screens/layout/cubit/states.dart';
class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({Key? key}) : super(key: key);

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'All Doctors',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: 60,
                      ),

                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_forward))

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Expanded(
                    child: AnimatedConditionalBuilder(
                      condition: PsychologyCubit.get(context).doctors.length>0,
                      builder: (context)=> ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)=>buildDoctorItem(context,PsychologyCubit.get(context).doctors[index]),
                          separatorBuilder:(context,index)=> Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                          ),
                          itemCount:PsychologyCubit.get(context).doctors.length
                      ),
                      fallback: (context)=>Center(child: CircularProgressIndicator(),),
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

  Widget buildDoctorItem(context,DoctorModel model)=> InkWell(
    onTap: (){
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 20.0,bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('images/dd.png'),
          ),
          SizedBox(
            width: 20,
          ),
          Text('${model.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ],
      ),
    ),
  );
}

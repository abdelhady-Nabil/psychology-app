import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/admin/user_details_screen.dart';
import 'package:psychology_app/model/user_model.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/layout/cubit/states.dart';
import 'package:psychology_app/screens/layout/layout_screen.dart';
import 'package:psychology_app/screens/chat_doctor/chat_details_screen.dart';
class PatientScreen extends StatelessWidget {
  const PatientScreen({Key? key}) : super(key: key);

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
                        'Patients',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: 100,
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
                      condition: PsychologyCubit.get(context).users.length>0,
                      builder: (context)=> ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)=>PatientItem(context,PsychologyCubit.get(context).users[index]),
                          separatorBuilder:(context,index)=> Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                          ),
                          itemCount:PsychologyCubit.get(context).users.length
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

  Widget PatientItem(context,UserModel model)=> InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetailsScreenAdmin(model: model)));
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 20.0,bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('images/man.png'),
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

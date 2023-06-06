import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/model/user_model.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/layout/cubit/states.dart';
import 'package:psychology_app/screens/measure/chat_details_screen.dart';
class ChatDoctorScreen extends StatelessWidget {
  const ChatDoctorScreen({Key? key}) : super(key: key);

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
                    children: [
                      Text(
                        'Chats',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward))

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>buildChatItem(context,PsychologyCubit.get(context).users[index]),
                        separatorBuilder:(context,index)=> Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                        itemCount: PsychologyCubit.get(context).users.length
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

  Widget buildChatItem(context,UserModel model)=> InkWell(
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>ChatDetailsScreen(model: model)));
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

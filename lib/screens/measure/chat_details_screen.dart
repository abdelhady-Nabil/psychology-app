
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/model/user_model.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/layout/cubit/states.dart';
import 'package:psychology_app/widget/constant.dart';
class ChatDetailsScreen extends StatelessWidget {

  late UserModel model ;
  ChatDetailsScreen({super.key, required this.model});

  final messageTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit,PsychologyState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('images/dd.png'),
                ),
                SizedBox(
                  width: 20,
                ),
                Text('${model.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
              ],
            ),

          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                buildMessage(),
                buildMyMessage(),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageTextController,
                          onChanged: (value){
                            //massageText = value;
                          },

                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            hintText: 'Enter your massage here',
                            border: InputBorder.none,
                          ),

                        )
                    ),
                    TextButton(
                        onPressed: (){
                          //messageTextController.clear();
                          PsychologyCubit.get(context).sendMessage(
                              receiverId: model.userId,
                              dateTime: DateTime.now(),
                              text: messageTextController.text
                          );
                        },
                        child: const Text('Send',style:TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ) ,)
                    ),
                  ],
                ),
              ],
            ),
          ),

        );
      },
    );
  }

  Widget buildMessage()=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Material(
        elevation: 10,
        borderRadius:BorderRadius.only(
          topLeft: Radius.circular(30),
          //bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Hello Abdoksk',style: TextStyle(color: Colors.white,fontSize: 15),),
        )
    ),
  );
  Widget buildMyMessage()=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Material(
        elevation: 10,
        borderRadius:BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          //bottomRight: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: PrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Hello Abdoksk',style: TextStyle(color: Colors.white,fontSize: 15),),
        )
    ),
  );
}

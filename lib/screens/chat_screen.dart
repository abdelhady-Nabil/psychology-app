import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psychology_app/widget/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'layout/layout_screen.dart';


final _firestore = FirebaseFirestore.instance; // instance from cloud fire store
late User signedInUser;
// this will give us the email

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? massageText; //massage user enter //this will give us the massage


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){


    try{
      final user = _auth.currentUser;

      if(user != null){
        signedInUser=user;
        print(signedInUser.email);
      }

    }catch(e){
      print(e);
    }

  }

  //get massage
  // void getMassages()async{
  //   final massages = await _firestore.collection('massags').get();
  //   //massages.docs; // all massages in cloud
  //   for(var massage in massages.docs){
  //     print(massage.data());
  //   };
  //
  // }

  void massageStreams ()async{
    await for( var snapShot in _firestore.collection('massags').snapshots()){
      for(var massage in snapShot.docs){
        print(massage.data());
      }
    };

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: PrimaryColor,
        title: Text('محادثاتي'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
            //massageStreams();
          }, icon: Icon(Icons.arrow_forward))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //send and receive massage
            MessageStreamBuilder(),

            //field and button send
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                        color: Colors.deepPurple,
                        width: 2,
                      )
                  )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value){
                          massageText = value;
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
                        messageTextController.clear();
                        _firestore.collection('massags').add({
                          'text':massageText,
                          'sender':signedInUser.email,
                          'time' : FieldValue.serverTimestamp()
                        });
                      },
                      child: const Text('Send',style:TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ) ,)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _firestore.collection('massags').orderBy('time').snapshots(),
        builder: (context,snapshot){

          List<TextMessage>messageWidgets = [];

          //when no data
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: PrimaryColor,
              ),
            );
          }

          final messages =snapshot.data!.docs.reversed;
          for(var message in messages){
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final currentUser = signedInUser.email;

            // if(currentUser==messageSender){
            //
            // }

            final messageWidget = TextMessage(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageWidgets.add(messageWidget);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              children: messageWidgets,
            ),
          );
        },
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({this.text,this.sender,required this.isMe,Key? key}) : super(key: key);
  final String? sender;
  final String? text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text('$sender',style: TextStyle(fontSize: 12,color: Colors.black45),),
          Material(
              elevation: 10,
              borderRadius:isMe ?BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
              ) : BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
              ) ,
              color: isMe ? PrimaryColor : Colors.teal,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('$text',style: TextStyle(color: Colors.white,fontSize: 15),),
              )
          ),
        ],
      ),
    );
  }
}

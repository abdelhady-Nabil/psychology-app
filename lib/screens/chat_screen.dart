import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psychology_app/widget/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _firestore = FirebaseFirestore.instance; // instance from cloud fire store
  final _auth = FirebaseAuth.instance;
  late User signedInUser; // this will give us the email
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
        backgroundColor: PrimaryColor,
        title: Text('محادثاتي'),
        actions: [
          IconButton(onPressed: (){
            massageStreams();
          }, icon: Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            //send and receive massage
            Container(
              child: StreamBuilder(
                stream: _firestore.collection('massags').snapshots(),
                builder: (context,snapshot){

                  List<Text>messageWidgets = [];

                  //when no data
                  if(!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: PrimaryColor,
                      ),
                    );
                  }

                  final messages =snapshot.data!.docs;
                  for(var message in messages){
                    final messageText = message.get('text');
                    final messageSender = message.get('sender');
                    final messageWidget = Text('$messageText - $messageSender');
                    messageWidgets.add(messageWidget);
                  }

                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      children: messageWidgets,
                    ),
                  );
                },
              ),
            ),

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
                        _firestore.collection('massags').add({
                          'text':massageText,
                          'sender':signedInUser.email
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

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:psychology_app/screens/layout/layout_screen.dart';
import 'package:psychology_app/widget/constant.dart';

import 'call_screen.dart';
class StartCall extends StatefulWidget {
  const StartCall({Key? key}) : super(key: key);

  @override
  State<StartCall> createState() => _StartCallState();
}

class _StartCallState extends State<StartCall> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(


          crossAxisAlignment: CrossAxisAlignment.center,


          children: [

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'الاستشاره الاون لاين',style: TextStyle(fontSize: 20,),),
                  SizedBox(
                    width: 50,
                  ),

                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_forward))

                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ادخل كود الدخول الخاص يك',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: PrimaryColor),),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller:_controller ,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: ()async{

                      await [Permission.camera,Permission.microphone].request().then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CallScreen(channelName: _controller.text.trim())));
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          color: PrimaryColor,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Text('ابدا',style: TextStyle(color: Colors.white,fontSize: 16),)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:psychology_app/widget/constant.dart';
class SuccessAddDoctor extends StatelessWidget {
  const SuccessAddDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: Text('add Doctor success'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Congratulation' ,style: TextStyle(color: PrimaryColor,fontSize: 30),),
            Text('Add Doctor Success' ,style: TextStyle(color: PrimaryColor,fontSize: 30),),
          ],
        ),
      ),
    );
  }
}

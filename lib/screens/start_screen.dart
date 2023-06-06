import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/login/login_screen.dart';
import '../widget/constant.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset('images/logo1.jpg'),
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }, child: const Text('Skip',style: TextStyle(
              fontSize: 20,
              color: PrimaryColor
            ),)),

          ],
        ),
      )
    );
  }
}

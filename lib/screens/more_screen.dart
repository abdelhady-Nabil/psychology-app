import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psychology_app/widget/constant.dart';

import 'auth/login_screen.dart';
class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MoreScreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.grey,
              child: IconButton(
                icon: Icon(Icons.logout_outlined),
                onPressed: (){
                  _auth.signOut();
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                  print('log out');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

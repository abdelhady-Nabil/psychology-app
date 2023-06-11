import 'package:flutter/material.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('مرحبا دكتور احمد',style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}

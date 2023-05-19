import 'package:flutter/material.dart';
import 'package:psychology_app/screens/chat_screen.dart';
import 'package:psychology_app/screens/home_screen.dart';
import 'package:psychology_app/screens/layout_screen.dart';
import 'package:psychology_app/screens/auth/login_screen.dart';
import 'package:psychology_app/screens/measure/goal_measure.dart';
import 'package:psychology_app/screens/measure/measure_screen.dart';
import 'package:psychology_app/screens/measure/reasult_screen.dart';
import 'package:psychology_app/screens/auth/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:psychology_app/screens/start_screen.dart';
import 'package:psychology_app/screens/measure/test_screen.dart';
import '../widget/custom_item.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized(); //access binding firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        fontFamily: 'cairo'
      ),
      debugShowCheckedModeBanner: false,
      home:   const Directionality(
        textDirection: TextDirection.ltr,
          child: LayoutScreen()
      ),
    );
  }
}

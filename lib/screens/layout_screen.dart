import 'package:flutter/material.dart';
import 'package:psychology_app/screens/home_screen.dart';
import 'package:psychology_app/screens/time_screen.dart';

import '../widget/constant.dart';
import 'chat_screen.dart';
import 'measure/measure_screen.dart';
import 'more_screen.dart';
class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int index = 4;
  List<Widget>screens=[
    MoreScreen(),
    MeasureScreen(),
    TimeScreen(),
    ChatScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(


        currentIndex: index,
        onTap: (value){
          setState(() {
            index=value;
            screens[index];
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: PrimaryColor,
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'المزيد',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'المقاييس'

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_alert),
              label: 'المواعيد'

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'محادثتي'

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسيه'

          ),
        ],
      ),
    );
  }
}

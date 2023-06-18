import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/screens/home_screen.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/layout/cubit/states.dart';
import 'package:psychology_app/screens/time_screen.dart';


import '../../widget/constant.dart';
import '../call/start_call.dart';
import '../chat_doctor/chat_doctor_screen.dart';
import '../chat_screen.dart';
import '../measure/measure_screen.dart';
import '../more_screen.dart';
class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int index = 5;
  List<Widget>screens=[
    MoreScreen(),
    MeasureScreen(),
    TimeScreen(),
    StartCall(),
    ChatDoctorScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>PsychologyCubit()..getDoctors()..getUserData()..getUsers()..getDoctorData(),
      child: BlocConsumer<PsychologyCubit,PsychologyState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            body: screens[index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              onTap: (value){
                if(value == 4 ){
                  PsychologyCubit.get(context).getUsers();
                }
                // if(value == 4 ){
                //   PsychologyCubit.get(context).getChatDoctors();
                // }
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
                    icon: Icon(Icons.calendar_month_outlined),
                    label: 'الحجز'

                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.video_call_outlined),
                    label: 'فيديو'

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
        },

      ),
    );
  }
}

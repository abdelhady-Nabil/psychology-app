import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:psychology_app/auth/login/login_screen.dart';
import 'package:psychology_app/screens/chat_screen.dart';
import 'package:psychology_app/screens/home_screen.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/screens/layout/layout_screen.dart';
import 'package:psychology_app/screens/measure/goal_measure.dart';
import 'package:psychology_app/screens/measure/measure_screen.dart';
import 'package:psychology_app/screens/measure/reasult_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:psychology_app/screens/more_screen.dart';
import 'package:psychology_app/screens/start_screen.dart';
import 'package:psychology_app/screens/measure/test_screen.dart';
import 'package:psychology_app/shared/bloc_observer.dart';
import 'package:psychology_app/shared/cache_helper.dart';
import 'package:psychology_app/user_provider.dart';
import 'package:psychology_app/widget/constant.dart';
import '../widget/custom_item.dart';


void main()async{
  Bloc.observer = const SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized(); //access binding firebase
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget widget;

  uid =CacheHelper.getData(key:'uid');

  if(uid != null){
    widget = LayoutScreen();
  }else{
    widget = LoginScreen();
  }

  runApp(MultiBlocProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      BlocProvider(
          create:(BuildContext context)=>PsychologyCubit()..getUserData()..getUsers()
      ),
    ],
    child: MyApp(
      startWidget :widget,
    ),
  ),);
}

class MyApp extends StatelessWidget {
   MyApp({Key? key,required this.startWidget}) : super(key: key);
   final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        fontFamily: 'cairo'
      ),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.ltr,
          child: startWidget,
      ),
    );
  }
}

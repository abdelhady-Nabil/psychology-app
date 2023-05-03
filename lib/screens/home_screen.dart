import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:psychology_app/screens/test_screen.dart';
import 'package:psychology_app/widget/constant.dart';

import '../model/question_model.dart';
import '../widget/custom_item.dart';
import '../widget/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  List <QuestionModel> questionList = getQuestion();


  void getCurrentUser(){

    try{
      final user = _auth.currentUser;
      if(user != null){
        signedInUser= user;
        print(signedInUser.email);
      }
    }
    catch(error){
      print(error);

    }



  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('psychology app',style: TextStyle(color: Colors.deepPurpleAccent),),
        actions: const [
          Icon(Icons.add_alert,color: Colors.deepPurpleAccent,),
        ],
        leading: Row(
          children: const [
            Icon(Icons.shopping_cart,color: Colors.deepPurpleAccent,),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.shopping_cart,color: Colors.deepPurpleAccent,)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [

                    Container(
                      width: 170,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.tealAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text('ما هو شعورك اليوم ؟')),

                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: const [
                        Text(', اهلا بك',style: TextStyle(color: Colors.grey,fontSize: 20),),
                        Text('عبدالهادي',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),

                  ],
                ) ,
               const SizedBox(
                  height: 20,
                ),
                Container(
                  width:double.infinity,
                  height: 100,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(4, 8)

                      ),

                    ]
                  ),
                  child:Image.asset('images/help.png',fit: BoxFit.fill,),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  const [
                     Text(' ! ابدا رحلتك الان',style: TextStyle(color: PrimaryColor,fontWeight: FontWeight.bold,fontSize: 20),),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                 SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomItem(
                        title:'مقياس تقدير الذات',
                        image: 'images/3.png',
                        number: questionList.length.toInt(),
                        color: Colors.teal,
                        function: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>TestScreen(
                                    title: 'مقياس تقدير الذات',
                                  )));
                        },
                      ),
                      CustomItem(
                        title:'مقياس الرضا الزواجي',
                        image: 'images/1.png',
                        number: 10,
                        color: Colors.pink,
                        function:(){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>TestScreen(
                                    title: 'مقياس الرضا الزواجي',
                                  )));
                        },

                      ),
                      CustomItem(
                        title:'مقياس الاكتاب الحاد',
                        image: 'images/5.png',
                        number: 10,
                        color: Colors.deepPurpleAccent,
                        function: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>TestScreen(
                                    title: 'مقياس الاكتاب الحاد',
                                  )));
                        },

                      ),
                      CustomItem(
                        title:'مقياس القلق الدائم',
                        image: 'images/4.png',
                        number: 10,
                        color: Colors.deepOrange,
                        function: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>TestScreen(
                                    title: 'مقياس القلق الدائم',
                                  )));
                        },

                      ),
                      CustomItem(
                        title:'مقياس الوسواس ',
                        image: 'images/2.png',
                        number: 10,
                        color: Colors.indigo,
                        function: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>TestScreen(
                                    title: 'مقياس الوسواس',
                                  )));
                        },

                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children:  [
                    CustomText(
                      text: 'عرض الكل',
                      fontSize: 10,
                      color: Colors.grey,

                    ),
                    Spacer(),
                    CustomText(
                      text: 'مجموعات الدعم',
                      fontSize: 15,
                      color:PrimaryColor,
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                              child: Image.asset('images/1.png'),
                            width: 100,
                            height: 100,
                          ),
                          Text('General'),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            child: Image.asset('images/children.png'),
                            width: 100,
                            height: 100,
                          ),
                          Text('child'),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            child: Image.asset('images/g.jpg'),
                            width: 100,
                            height: 100,
                          ),
                          Text('General'),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children:[
                          Container(
                            child: Image.asset('images/g.jpg'),
                            width: 100,
                            height: 100,
                          ),
                          Text('General'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        unselectedItemColor: Colors.grey,
        selectedItemColor: PrimaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home'

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_sharp),
            label: 'date'

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert_outlined),
            label: 'alert'

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'me'

          )
        ],
      ),
    );
  }

}

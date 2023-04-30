import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:psychology_app/widget/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  late User signedInUser;

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Welcome , Abdo',style: TextStyle(color: Colors.grey,fontSize: 20),),
                        SizedBox(
                          height: 5,
                        ),
                        Text('What do you feel ?',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                      ],
                    ),
                    Spacer(),
                    const CircleAvatar(
                      backgroundImage: AssetImage('images/logo.jpg'),
                      radius: 25,
                    ),
                  ],
                ) ,
               const SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width:double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Search here '),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children:  [
                    const Text('Find your doctor ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                    Spacer(),
                    TextButton(onPressed: (){}, child: const Text('See All',style: TextStyle(color: PrimaryColor),))

                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                 SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Container(
                            width: 150,
                            height: 200,

                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image(image: AssetImage('images/ddd.png')),



                          ),
                           Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('DR.Ahmed ,35',style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),),
                                Text('child psychologist ',style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),),
                              ],
                            ),
                          )
                        ],
                      ),

                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 150,
                        height: 200,

                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image(image: AssetImage('images/dd2.png'),),



                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 150,
                        height: 200,

                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image(image: AssetImage('images/dd5.png'),),



                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 150,
                        height: 200,

                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image(image: AssetImage('images/dd3.png'),),



                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 150,
                        height: 200,

                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image(image: AssetImage('images/dd4.png'),),



                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children:  [
                    const Text('Categories ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                    Spacer(),
                    TextButton(onPressed: (){}, child: const Text('See All',style: TextStyle(color: PrimaryColor),))

                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
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

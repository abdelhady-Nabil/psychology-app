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
                      Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [

                          Container(
                            width: 150,
                            height: 200,

                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Padding(
                              padding:  EdgeInsets.only(top: 70),
                              child: Image(image: AssetImage('images/3.png')),
                            ),



                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('مقياس تقدير الذات',style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),),
                                Text('10 اساله',style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),),
                              ],
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(
                        width: 20,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [

                          Container(
                            width: 150,
                            height: 200,

                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Padding(
                              padding:  EdgeInsets.only(top: 40),
                              child: Image(image: AssetImage('images/1.png')),
                            ),



                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('مقياس الرضا الزاجي',style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),),
                                Text('10 اساله',style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),),
                              ],
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [

                          Container(
                            width: 150,
                            height: 200,

                            decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Padding(
                              padding:  EdgeInsets.only(top: 40),
                              child: Image(image: AssetImage('images/2.png')),
                            ),



                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('مقياس الرضا الزاجي',style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),),
                                Text('10 اساله',style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),),
                              ],
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      customItem(
                        image: '5',
                        title: 'مقياس الاكتاب',
                        number: 15,
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
  Widget customItem({
  required String title,
    required String image,
    required int number,

}){
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [

        Container(
          width: 150,
          height: 200,

          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding:  const EdgeInsets.only(top: 50),
            child: Image(image: AssetImage('images/$image.png')),
          ),



        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
              Text('$title',style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
              Text('$number',style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white
              ),),
            ],
          ),
        ),

      ],
    );
  }
}

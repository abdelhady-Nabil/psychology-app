import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/admin/patient_screen.dart';
import 'package:psychology_app/auth/login/login_screen.dart';
import 'package:psychology_app/screens/layout/cubit/cubit.dart';
import 'package:psychology_app/widget/constant.dart';

import '../model/doctor_model.dart';
import '../model/user_model.dart';
import '../screens/layout/cubit/states.dart';
import 'Doctors_screen.dart';
import 'add_doctor_screen.dart';
class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit,PsychologyState>(
      listener: (context,state){},
      builder: (context,state){
        var numberOfDoctor = PsychologyCubit.get(context).doctors.length;
        var numberOfPatient = PsychologyCubit.get(context).users.length;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: PrimaryColor,
            title: Text('Dashboard'),
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              children:  [
                //header
                Container(
                  color: PrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/dd.png'),
                          radius: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Admin 1',style: TextStyle(color: Colors.white),),
                        Text('Admin 1@ yahoo.com',style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: (){
                    PsychologyCubit.get(context).getDoctors();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsScreen()));
                  },
                  title: Text('Doctors'),
                  leading: Icon(Icons.medical_services_outlined),
                ),
                ListTile(
                  onTap: (){
                    PsychologyCubit.get(context).getUsers();
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>PatientScreen()));
                  },
                  title: Text('patient'),
                  leading: Icon(Icons.sick_outlined),
                ),
                ListTile(
                  title: Text('Earning'),
                  leading: Icon(Icons.monetization_on_outlined),
                ),
                ListTile(
                  title: Text('Booking'),
                  leading: Icon(Icons.local_activity_outlined),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                ListTile(
                  onTap: (){
                    PsychologyCubit.get(context).signOut(context);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                  },
                  title: Text('log out'),
                  leading: Icon(Icons.logout),
                ),


              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,top: 10,right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('Hello , Admin',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text('Welcome back'),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text('add new doctor',style: TextStyle(fontSize: 15),),
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDoctorScreen()));
                          }, icon: Icon(Icons.add_reaction_outlined)),

                        ],
                      )
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //card item
                  Row(
                    children: [
                      Expanded(
                        child: buildItem(
                          title: 'Total Doctor',
                          number: numberOfDoctor,
                          icon: Icons.account_box_outlined,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: buildItem(
                          title: 'Total Patient',
                          number: numberOfPatient,
                          icon: Icons.sick_outlined,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildItem(
                          title: 'Total Booking',
                          number: 11,
                          icon: Icons.account_box_outlined,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: buildItem(
                          title: 'Total Earning',
                          number: 10,
                          icon: Icons.monetization_on_outlined,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text('Doctors',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      Spacer(),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsScreen()));
                      }, child:Text('see all',style: TextStyle(color: PrimaryColor),))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //List of doctors
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      physics: ClampingScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,

                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>DoctorItem(context,PsychologyCubit.get(context).doctors[index]),
                        separatorBuilder: (context,index)=> SizedBox(
                          width: 10,
                        ),
                        itemCount: PsychologyCubit.get(context).doctors.length),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Text('Patients',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      Spacer(),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientScreen()));
                      }, child:Text('see all',style: TextStyle(color: PrimaryColor),))
                    ],
                  ),

                  // Lis of Patient
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                        physics: ClampingScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>PatientItem(context,PsychologyCubit.get(context).users[index]),
                        separatorBuilder: (context,index)=> SizedBox(
                          width: 10,
                        ),
                        itemCount: PsychologyCubit.get(context).users.length),
                  ),


                  SizedBox(
                    height: 20,
                  ),




                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildItem({
  required int number,
    required IconData icon,
    required String title
}){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('$number',style: TextStyle(color: PrimaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
                Spacer(),
                Icon(icon,color: PrimaryColor,)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('$title',style: TextStyle(color: PrimaryColor,fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Widget DoctorItem(context,DoctorModel model){
    return Column(
      children: [
        Container(
          height: 120,
          width: 170,
          child: Image.asset('images/dd.png'),
        ),
        SizedBox(
          height: 10,
        ),
        Text('${model.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
      ],
    );
  }

  Widget PatientItem(context,UserModel model){
    return Column(
      children: [
        Container(
          height: 120,
          width: 170,
          child: Image.asset('images/man.png'),
        ),
        SizedBox(
          height: 10,
        ),
        Text('${model.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
      ],
    );
  }

}

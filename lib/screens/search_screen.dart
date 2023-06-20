import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/model/doctor_model.dart';
import 'package:psychology_app/screens/layout/layout_screen.dart';

import '../widget/constant.dart';
import 'doctor_details.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController _searchController = TextEditingController();
  List<DoctorModel> _allDoctors = [];
  List<DoctorModel> _searchedDoctors = [];

  @override
  void initState() {
    super.initState();
    _fetchAllDoctors();
  }

  void _fetchAllDoctors() async {
    final snapshot = await FirebaseFirestore.instance.collection('doctors').get();
    setState(() {
      _allDoctors = snapshot.docs.map((doc) => DoctorModel.fromJson(doc.data())).toList();
      _searchedDoctors = _allDoctors;
    });
  }

  void _searchDoctors(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchedDoctors = _allDoctors;
      } else {
        _searchedDoctors = _allDoctors
            .where((doctor) =>
            doctor.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit,PsychologyState>(
      listener: (context,state){},
        builder: (context,state){
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _searchController,
                              onChanged: (value) {
                                _searchDoctors(value);
                              },
                              decoration: InputDecoration(
                                  hintText: 'بحث',
                                  alignLabelWithHint: true,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.fromLTRB(0, 8, 10, 8)
                              ),
                              textAlign: TextAlign.right,
                              cursorColor: PrimaryColor,
                              cursorHeight: 20,
                            ),
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
                      }, icon: Icon(Icons.arrow_forward,color: PrimaryColor,)),

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: _searchedDoctors.length==0 ?
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Text('لا يوجد دكتور بهذا الاسم',style: TextStyle(color: PrimaryColor,fontSize: 20),),

                            SizedBox(
                              height: 20,
                            ),
                            Image.asset('images/not.jpg'),

                          ],
                        ),
                      ),
                    ):
                    ListView.separated(
                        itemBuilder: (context,index){
                          return itemBuilder(_searchedDoctors[index]);
                        },
                        separatorBuilder: (context,index)=>SizedBox(height: 20,),
                        itemCount: _searchedDoctors.length
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        }

    );
  }

 Widget itemBuilder(DoctorModel model){

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDetails(model: model,)));
      },
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'طبيب نفسي',
                style: TextStyle(fontSize: 15, color:Colors.black),
              ),
              Spacer(),
              Text(
                'Dr. ِ${model.name}',
                style: TextStyle(fontSize: 18, color: PrimaryColor),
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/dd.png'),
              ),
            ],
          ),
        ),
      ),
    );

  }


}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:psychology_app/screens/layout/layout_screen.dart';
import 'package:psychology_app/widget/constant.dart';

import '../screens/layout/cubit/cubit.dart';
import '../screens/layout/cubit/states.dart';
import 'doctor_home.dart';

class SettingDoctorScreen extends StatefulWidget {
  const SettingDoctorScreen({Key? key}) : super(key: key);

  @override
  State<SettingDoctorScreen> createState() => _SettingDoctorScreenState();
}

class _SettingDoctorScreenState extends State<SettingDoctorScreen> {

  final TextEditingController  _newNameTextController = TextEditingController();
  final TextEditingController  _newEmailTextController = TextEditingController();
  final TextEditingController  _newphoneController = TextEditingController();
  final TextEditingController  _newpasswordController = TextEditingController();



  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PsychologyCubit,PsychologyState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: PrimaryColor,
              centerTitle: true,
              title: Text('seeting'),
            ),
            body: Form(
              key: _formKey,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          const Text('Update Data',style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                label:Text('Enter New Name',style: TextStyle(color: PrimaryColor),),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PrimaryColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PrimaryColor)
                                ),
                                // border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person,color: PrimaryColor,)

                            ),
                            cursorColor: PrimaryColor,
                            controller:_newNameTextController ,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter your Name";
                              }
                              return null;
                            },
                            onChanged: (value){
                              value = _newNameTextController.text;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                label:Text('Enter New Email',style: TextStyle(color: PrimaryColor),),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PrimaryColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PrimaryColor)
                                ),
                                // border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email,color: PrimaryColor,)

                            ),
                            cursorColor: PrimaryColor,
                            controller:_newEmailTextController ,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter your Email";
                              }
                              final bool isValid = EmailValidator.validate(value);
                              if(!isValid){
                                return "Invalid Email Address";
                              }
                              return null;
                            },
                            onChanged: (value){
                              value = _newEmailTextController.text;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              label:Text('Enter New Password',style: TextStyle(color: PrimaryColor),),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock,color: PrimaryColor,),
                              suffixIcon: Icon(Icons.remove_red_eye,color: PrimaryColor,),

                            ),
                            cursorColor: PrimaryColor,
                            controller:_newpasswordController ,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter your password";
                              }
                            },

                            onChanged: (value){
                              value = _newpasswordController.text;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              label:Text('Enter New phone',style: TextStyle(color: PrimaryColor),),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.phone,color: PrimaryColor,),
                              prefixText: '+2',
                            ),
                            maxLength: 11,

                            cursorColor: PrimaryColor,
                            controller:_newphoneController ,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter your phone";
                              }
                              if(value.length < 11){
                                return "Incorrect phone Number";
                              }
                              return null;
                            },
                            onChanged: (value){
                              value = _newphoneController.text;
                            },
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            width: double.infinity,
                            height:50,
                            color: PrimaryColor,
                            child: TextButton(
                              onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                  // Validation passed, proceed with updating user information
                                  updateUserInformation();
                                }
                              },
                              child: const Text('Update',style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

    );
  }
  void updateUserInformation() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;

        String newName = _newNameTextController.text.trim();
        String newEmail = _newEmailTextController.text.trim();
        String newPassword = _newpasswordController.text.trim();
        String newPhone = _newphoneController.text.trim();

        // Create a map of updated user information
        Map<String, dynamic> updatedData = {};

        if (newName.isNotEmpty) {
          updatedData['name'] = newName;
        }

        if (newEmail.isNotEmpty) {
          updatedData['emil'] = newEmail;
          await user.updateEmail(newEmail);
        }

        if (newPassword.isNotEmpty) {
          updatedData['password'] = newPassword;
          await user.updatePassword(newPassword);
        }

        if (newPhone.isNotEmpty) {
          updatedData['phone'] = newPhone;
        }

        // Update the user document in Firebase Firestore
        CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('doctors');
        await usersCollection.doc(uid).update(updatedData);
        print('User information updated successfully');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorHomeScreen()));
      }
    } catch (error) {
      print('Failed to update user information: $error');
    }
  }
}

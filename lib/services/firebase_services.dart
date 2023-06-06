
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:psychology_app/model/user_model.dart';

class FirebaseServices{

  final auth = FirebaseAuth.instance; //instance from firebase auth
  User? user = FirebaseAuth.instance.currentUser;//current user
  FirebaseFirestore firestore = FirebaseFirestore.instance; // instance from firebase store
  CollectionReference users = FirebaseFirestore.instance.collection('users'); // collection user


  //add anew user to collection user
  // Future<void> addUserData({required Map<String , dynamic> data}) {
  //   // Call the user's CollectionReference to add a new user
  //   return users.doc(user?.uid)
  //       .set(data)
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  Future<void> addUserToFireStore(UserModel usermodel){
    return users.doc(usermodel.userId)
        .set(usermodel.toMap());
  }







}
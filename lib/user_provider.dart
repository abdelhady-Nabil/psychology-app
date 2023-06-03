import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psychology_app/services/firebase_services.dart';

class UserProvider with ChangeNotifier{

  final FirebaseServices _services = FirebaseServices();
   DocumentSnapshot? ds;

  getUserData(){

    _services.users.doc(_services.user?.uid).get().then((value){
      ds=value;
      notifyListeners();

    });
  }

}
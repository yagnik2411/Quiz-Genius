import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_genius/firebase/CRUD.dart';

class CurretUser {
   static late  UserName currentUser ;
}



class UserName {
  final String email;
  final String password;
   String userName;

  UserName({required this.email, required this.password, this.userName = ""});

  String setUserName(String userName) => this.userName = userName;

  String getUserName() => userName;

  void add ({ required BuildContext context}) async {
    Map<String,String> data = {
      "email": email,
      "password": password,
      "userName": userName,
    };
    DocumentReference firestore= FirebaseFirestore.instance.collection("users").doc("${data["email"]}");
    await
    CRUD(firestore).add(data: data, context: context);
  }
}

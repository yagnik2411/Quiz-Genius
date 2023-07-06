import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CurretUser {
  static late UserName currentUser;
}

class UserName {
  final String email;
  final String password;
  String userName;
  int Quizid;

  UserName(
      {required this.email,
      required this.password,
      this.userName = "",
      this.Quizid = 1});

  String setUserName(String userName) => this.userName = userName;

  void setQuizId(int Quizid) => this.Quizid = Quizid;

  int getQuizId() => this.Quizid;

  void add({required BuildContext context}) async {
    Map<String, String> data = {
      "email": email,
      "password": password,
      "userName": userName,
      "Quizid": Quizid.toString(),
    };
    DocumentReference firestore =
        FirebaseFirestore.instance.collection("users").doc("${data["email"]}");
    // await CRUD(firestore).add(data: data, context: context,firestore: firestore);
    await firestore
        .set(data)
        .whenComplete(() => print("data added"))
        .onError((error, stackTrace) => print(error));
  }
}

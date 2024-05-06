import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CurrentUser {
  static late UserName currentUser;
}

class UserName {
  final String email;
  final String password;
  String userName;
  int performance;

  UserName(
      {required this.email,
      required this.password,
      this.userName = "",
      this.performance = 100});

  String setUserName(String userName) => this.userName = userName;

  performanceUpdate(
      {required BuildContext context,
      required String currentEmail,
      required int currentPerformance}) async {
    DocumentReference firestore =
        FirebaseFirestore.instance.collection("users").doc(currentEmail);
    await firestore.update({
      'performance': currentPerformance,
    });
    performance = currentPerformance;
  }

  void add({required BuildContext context}) async {
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
      "userName": userName,
      "performance": performance,
    };
    DocumentReference firestore =
        FirebaseFirestore.instance.collection("users").doc("${data["email"]}");

    await firestore
        .set(data)
        .whenComplete(() => print("data added"))
        .onError((error, stackTrace) => print(error));
  }
}

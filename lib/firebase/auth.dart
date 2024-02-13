import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:quiz_genius/utils/toast.dart';

class Auth {
  final FirebaseAuth _auth;

  Auth(this._auth);

  Future<void> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          print('auth:name ${email} pass ${password}');
    } on FirebaseAuthException catch (e) {
      toMassage(msg: "Sighup Fail");
    }
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    print('auth:name ${email} pass ${password}');
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
    } on FirebaseAuthException catch (e) {
      print(e);
      toMassage(msg: "SignIn Fail");
    }
  }
}

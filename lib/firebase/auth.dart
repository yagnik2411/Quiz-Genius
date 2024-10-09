import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:quiz_genius/utils/toast.dart';

class Auth {
  final FirebaseAuth _auth;

  Auth(this._auth);

  Future<String> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('auth:name ${email} pass ${password}');
      toMassage(msg: "Sighup Complete");
      return "Signup Complete";
    } on FirebaseAuthException {
      toMassage(msg: "Sighup Fail");
      return "Signup Fail";
    }
  }

  Future<String> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    print('auth:name ${email} pass ${password}');
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
      toMassage(msg: "SignIn Complete");
      return "SignIn Complete";
    } on FirebaseAuthException catch (e) {
      print(e);
      toMassage(msg: "SignIn Fail");
      return "SignIn Fail";
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
    } on FirebaseAuthException catch (e) {
      print(e);
      toMassage(msg: "SignOut Fail");
    }
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_genius/firebase/auth.dart';
import 'package:quiz_genius/main.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:quiz_genius/utils/colors.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

 static final _formkey = GlobalKey<FormState>();

  String _email = "";

  String _password = "";

  moveToHome(BuildContext context) {
    CurretUser.currentUser = UserName(email: _email, password: _password);
    print("email ${_email} ");
    Auth(FirebaseAuth.instance).signIn(
        email: CurretUser.currentUser.email,
        password: CurretUser.currentUser.password,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      appBar: AppBar(
        backgroundColor: MyColors.mint,
        title: const Center(
          child: Text(
            "Login Page",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formkey,
        child: Column(
          children: [
             SizedBox(
              height: correctSize(20),
            ),
            SvgPicture.asset(
              "assets/images/login.svg",
              fit: BoxFit.contain,
              width: width / 1.2,
            ).centered().py(correctSize(24)),
             SizedBox(
              height: correctSize(20),
            ),
            "Welcome to Quiz Genius"
                .text
                .xl2
                .color(MyColors.malachite)
                .bold
                .center
                .makeCentered(),
             SizedBox(
              height: correctSize(20),
            ),
            Container(
              padding:  EdgeInsets.only(left: correctSize(20), right: correctSize(20), bottom: correctSize(10)),
              decoration: BoxDecoration(
                  color: MyColors.elfGreen.withOpacity(0.6),
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(correctSize(20)),
                    topRight: Radius.circular(correctSize(20)),
                  )),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "eg: abcd@gmail.com",
                  hintStyle: TextStyle(
                    color: Colors.deepPurple.withOpacity(0.4),
                  ),
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Email is invalid";
                  }
                  return null;
                },
                onChanged: (value) {
                  _email = value;
                },
              ),
            ).px(correctSize(16)),
            Container(
              padding:  EdgeInsets.only(left: correctSize(20), right: correctSize(20), bottom: correctSize(10)),
              decoration: BoxDecoration(
                  color: MyColors.elfGreen.withOpacity(0.6),
                  borderRadius:  BorderRadius.only(
                    bottomLeft: Radius.circular(correctSize(20)),
                    bottomRight: Radius.circular(correctSize(20)),
                  )),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "eg: 123456",
                  hintStyle: TextStyle(
                    color: Colors.deepPurple.withOpacity(0.4),
                  ),
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length < 6) {
                    return "Password length should be at least 6 characters";
                  }
                  return null;
                },
                onChanged: (value) {
                  _password = value;
                },
              ).pOnly(bottom: correctSize(10)),
            ).px(correctSize(16)),
             SizedBox(
              height: correctSize(10),
            ),
            ButtonBar(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      moveToHome(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MyColors.malachite),
                    elevation: MaterialStateProperty.all(10),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.white)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(correctSize(15)),
                      ),
                    ),
                  ),
                  child: const Text("Login"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, MyRoutes.signUpRoute);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyColors.mint),
                    elevation: MaterialStateProperty.all(10),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.white)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(correctSize(15)),
                      ),
                    ),
                  ),
                  child: const Text("Sign Up"),
                ).px(correctSize(12)),
              ],
            ).px(correctSize(16))
          ],
        ),
      )),
    );
  }
}

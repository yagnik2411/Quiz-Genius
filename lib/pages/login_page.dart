import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_genius/firebase/auth.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:quiz_genius/utils/colors.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  static final _formkey = GlobalKey<FormState>();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  moveToHome(BuildContext context) async {
    CurrentUser.currentUser = UserName(
        email: emailController.text, password: passwordController.text);
    print("email ${emailController.text} ");
    String ans = await Auth(FirebaseAuth.instance).signIn(
        email: CurrentUser.currentUser.email,
        password: CurrentUser.currentUser.password,
        context: context);
    if (ans == "SignIn Complete") {
      Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
    }
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
        key: Login._formkey,
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            SvgPicture.asset(
              "assets/images/login.svg",
              fit: BoxFit.contain,
              width: 393.w / 1.2,
            ).centered().py(24.sp),
            SizedBox(
              height: 20.h,
            ),
            "Welcome to Quiz Genius"
                .text
                .xl2
                .color(MyColors.malachite)
                .bold
                .center
                .makeCentered(),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 10.sp),
              decoration: BoxDecoration(
                  color: MyColors.elfGreen.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp),
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
                controller: emailController,
              ),
            ).px(16.sp),
            Container(
              padding:
                  EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 10.sp),
              decoration: BoxDecoration(
                  color: MyColors.elfGreen.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.sp),
                    bottomRight: Radius.circular(20.sp),
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
                controller: passwordController,
              ).pOnly(bottom: 10.sp),
            ).px(16.sp),
            SizedBox(
              height: 10.h,
            ),
            OverflowBar(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (Login._formkey.currentState!.validate()) {
                      moveToHome(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(MyColors.malachite),
                    elevation: WidgetStateProperty.all(10),
                    side: WidgetStateProperty.all(
                        const BorderSide(color: Colors.white)),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, MyRoutes.signUpRoute);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(MyColors.mint),
                    elevation: WidgetStateProperty.all(10),
                    side: WidgetStateProperty.all(
                        const BorderSide(color: Colors.white)),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                    ),
                  ),
                  child: const Text("Sign Up",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ).px(12.sp),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 60,
                  child: IconButton(
                      onPressed: () {
                        Auth(FirebaseAuth.instance)
                            .signInWithGoogle(context: context);
                      },
                      icon: Image.asset("assets/images/google.png")),
                ),
              ],
            ).px(16.sp)
          ],
        ),
      )),
    );
  }
}

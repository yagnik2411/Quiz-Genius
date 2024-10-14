import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_genius/firebase/auth.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:quiz_genius/utils/widget/validation_fucntion.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:quiz_genius/utils/colors.dart';

import '../utils/widget/custom_button.dart';
import '../utils/widget/custom_text_form.dart';

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
  bool _obscureText = true;

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
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: Login._formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/login.svg",
                  fit: BoxFit.contain,
                  width: 600.w / 1.2,
                ).centered().py(24.sp),
                SizedBox(
                  height: 10.h,
                ),
                "Welcome to Quiz Genius"
                    .text
                    .xl2
                    .color(MyColors.darkCyan)
                    .extraBold
                    .center
                    .makeCentered(),
                SizedBox(
                  height: 3.h,
                ),
                "Login to your account"
                    .text
                    .normal
                    .color(MyColors.darkCyan)
                    .normal
                    .center
                    .makeCentered(),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextForm(
                  controller: emailController,
                  validator: validateEmail,
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                  hintText: "eg:abcd@gmail.com",
                  keyboard: TextInputType.emailAddress,
                  icon: Icon(
                    Icons.email_outlined,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextForm(
                    controller: passwordController,
                    validator: validatePassword,
                    obscureText: _obscureText,
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                    hintText: "eg:123Hello!@",
                    keyboard: TextInputType.text,
                    icon: Icon(
                      Icons.lock_outlined,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black.withOpacity(0.8)),
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, MyRoutes.forgetRoute);
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomButton(
                  pressed: () {
                    if (Login._formkey.currentState!.validate()) {
                      moveToHome(context);
                    }
                  },

                  bgColor: MyColors.malachite,
                  text: "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                        text: "SignUp",
                        style: TextStyle(
                            color: MyColors.darkCyan,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, MyRoutes.signUpRoute);
                          }),
                  ])),
                ),

              ],
            ),
          )),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_genius/firebase/auth.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:quiz_genius/utils/colors.dart';

import '../utils/widget/custom_button.dart';
import '../utils/widget/custom_text_form.dart';
import '../utils/widget/validation_fucntion.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  Future<String> signUpUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    return await Auth(FirebaseAuth.instance)
        .signUp(email: email, password: password, context: context);
  }

  moveToUserPage(BuildContext context) async {
    if (SignUp._formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      SignUp._formKey.currentState!.save();
      CurrentUser.currentUser = UserName(email: email, password: password);
      print('sing up:name ${email} pass ${password}');
      String ans = await signUpUser(context);
     if (ans == "Signup Complete")
        Navigator.pushReplacementNamed(context, MyRoutes.usernameRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
          child: Form(
            key: SignUp._formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/login.svg",
                  fit: BoxFit.contain,
                  width: 600.w / 1.2,
                ).centered().py(24.sp),

                "SignUp to Quiz Genius"
                    .text
                    .xl2
                    .color(MyColors.darkCyan)
                    .extraBold
                    .center
                    .makeCentered(),
                SizedBox(
                  height: 3.h,
                ),
                "Create your account"
                    .text
                    .normal
                    .color(MyColors.darkCyan)
                    .normal
                    .center
                    .makeCentered(),
                SizedBox(
                  height: 20.h,
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
                SizedBox(
                  height: 20.h,
                ),

                CustomButton(
                  pressed: () {
                    moveToUserPage(context);
                  },
                  bgColor: MyColors.malachite,
                  text: "Sign up",
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
                      text: "Already have an account? ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                        text: "Login",
                        style: TextStyle(
                            color: MyColors.darkCyan,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, MyRoutes.loginRoute);
                          }),
                  ])),
                ),
              ],
            ),
          )),
    );
  }
}

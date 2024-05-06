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
class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  static final _formkey = GlobalKey<FormState>();

  String email = "";

  String password = "";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpUser(BuildContext context) async {
    Auth(FirebaseAuth.instance)
        .signUp(email: this.email, password: this.password, context: context);
    
  }

  moveToUserPage(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      CurrentUser.currentUser = UserName(email: this.email, password: this.password);
     print('sing up:name ${this.email} pass ${this.password}');
      signUpUser(context);
      Navigator.pushReplacementNamed(context, MyRoutes.usernameRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      appBar: AppBar(
        backgroundColor: MyColors.mint,
        title: Center(
          child: Text(
            "SignUp Page",
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
              height: 20.h,
            ),
            SvgPicture.asset(
              "assets/images/login.svg",
              fit: BoxFit.contain,
              width: (393 / 1.2).w,
            ).centered().py(24.sp),
             SizedBox(
              height: 20.h,
            ),
            "SignUp to Quiz Genius"
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
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 10.sp),
              decoration: BoxDecoration(
                  color: MyColors.elfGreen.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp),
                  )),
              child: TextFormField(
                controller: emailController,
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
                  this.email =  emailController.text;
                },
              ),
            ).px(16.sp),
            Container(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp, bottom:10.sp),
              decoration: BoxDecoration(
                  color: MyColors.elfGreen.withOpacity(0.6),
                  borderRadius:  BorderRadius.only(
                    bottomLeft: Radius.circular(20.sp),
                    bottomRight: Radius.circular(20.sp),
                  )),
              child: TextFormField(
                controller: passwordController,
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
                    return "Password length should be atleast 6";
                  }
                  return null;
                },
                onChanged: (value) {
                  this.password =   passwordController.text;
                },
              ).pOnly(bottom: 10.sp),
            ).px(16.sp),
            SizedBox(
              height: 10.h,
            ),
            ButtonBar(
              children: [
                ElevatedButton(
                  onPressed: () {
                    moveToUserPage(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MyColors.malachite),
                    elevation: MaterialStateProperty.all(10),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.white)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                    ),
                  ),
                  child: const Text("Sign Up"),
                ),
              ],
            ).px(16.sp)
          ],
        ),
      )),
    );
  }
}

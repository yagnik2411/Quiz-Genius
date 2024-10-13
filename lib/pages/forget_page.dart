import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_genius/utils/widget/validation_fucntion.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:quiz_genius/utils/colors.dart';

import '../utils/my_route.dart';
import '../utils/widget/custom_button.dart';
import '../utils/widget/custom_text_form.dart';

class ForgetPage extends StatefulWidget {
  ForgetPage({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
  try {
  await _auth.sendPasswordResetEmail(email: email);
  Fluttertoast.showToast(
    msg: "Password reset email sent!",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: MyColors.mint,
    textColor: Colors.black,
    fontSize: 16.0,
  );
  Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
  } catch (e) {
  Fluttertoast.showToast(
    msg: 'Error: ${e.toString()}',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: MyColors.mint,
    textColor: Colors.black,
    fontSize: 16.0,
  );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
          child: Form(
            key: ForgetPage._formKey,
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
                "Forget Password"
                    .text
                    .xl
                    .color(MyColors.darkCyan)
                    .extraBold
                    .center
                    .makeCentered(),
                SizedBox(
                  height: 30.h,
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
                  height: 30.h,
                ),
                CustomButton(
                  pressed: () {
                    if (ForgetPage._formKey.currentState!.validate()) {
                      resetPassword(emailController.text.trim());
                    }
                  },
                  bgColor: MyColors.malachite,
                  text: "Reset Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),

              ],
            ),
          )),
    );
  }
}

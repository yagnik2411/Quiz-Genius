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
class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  static final _formkey = GlobalKey<FormState>();

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  Future<String> signUpUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
   return await Auth(FirebaseAuth.instance)
        .signUp(email: email, password: password, context: context);
  }

  moveToUserPage(BuildContext context)async {
    if (SignUp._formkey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      SignUp._formkey.currentState!.save();
      CurrentUser.currentUser = UserName(email: email, password: password);
      print('sing up:name ${email} pass ${password}');
     String ans=await signUpUser(context);
     if(ans == "Signup Complete")
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
        key: SignUp._formkey,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              padding:
                  EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 10.sp),
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
                // onChanged: (value) {
                //   print("email" + value);
                //   email = value;
                //   print("email" + email);
                // },
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
                // onChanged: (value) {
                //   password = value;
                // },
              ).pOnly(bottom: 10.sp),
            ).px(16.sp),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120,right: 120),
              child: OverflowBar(

                children: [
                  ElevatedButton(
                    onPressed: () {
                      moveToUserPage(context);
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
                    child: Center(child: const Text("Sign Up" ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

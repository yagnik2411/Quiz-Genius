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

  moveToUserPage(BuildContext context) async {
    if (SignUp._formkey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      SignUp._formkey.currentState!.save();
      CurrentUser.currentUser = UserName(email: email, password: password);
      String ans = await signUpUser(context);
      if (ans == "Signup Complete")
        Navigator.pushReplacementNamed(context, MyRoutes.usernameRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700], // Changed background color
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Center(
          child: Text(
            "SignUp Page",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white), // Text color updated
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: SignUp._formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              SvgPicture.asset(
                "assets/images/login.svg",
                fit: BoxFit.contain,
                width: (393 / 1.2).w,
              ).centered().py(24.sp),
              SizedBox(height: 20.h),
              "SignUp to Quiz Genius"
                  .text
                  .xl2
                  .color(MyColors.seashall)
                  .bold
                  .center
                  .makeCentered(),
              SizedBox(height: 20.h),
              _buildTextField(
                controller: emailController,
                hintText: "eg: abcd@gmail.com",
                labelText: "Email",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Email is invalid";
                  }
                  return null;
                },
                isPasswordField: false,
              ),
              SizedBox(height: 15,),
              _buildTextField(
                controller: passwordController,
                hintText: "eg: 123456",
                labelText: "Password",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length < 6) {
                    return "Password length should be at least 6 characters";
                  }
                  return null;
                },
                isPasswordField: true,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.only(left: 120, right: 120),
                child: ElevatedButton(
                  onPressed: () {
                    moveToUserPage(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                    elevation: MaterialStateProperty.all(10),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    required String? Function(String?) validator,
    required bool isPasswordField,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
        border: Border.all(color: Colors.deepOrange),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPasswordField,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.deepPurple.withOpacity(0.4),
          ),
          labelText: labelText,
          border: InputBorder.none, // Remove underline
        ),
        validator: validator,
      ),
    ).px(16.sp);
  }
}

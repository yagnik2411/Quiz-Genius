import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_genius/utils/colors.dart';

import '../utils/my_route.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // Function to handle sending password reset email
  Future<void> _sendPasswordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password reset link sent to your email.")),
        );

        // Redirect to login page after sending the reset link
        Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
      } on FirebaseAuthException catch (e) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "An error occurred.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      appBar: AppBar(
          leading: IconButton(
                onPressed: () {
                  // Navigates back to the previous screen
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.back),
              ),
        title: const Text("Forgot Password"),
        backgroundColor: MyColors.mint,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter your email address to receive a password reset link.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!EmailValidator.validate(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _sendPasswordResetEmail,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(MyColors.malachite),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                        ),
                      ),
                      child: Text(
                        "Send Reset Link",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

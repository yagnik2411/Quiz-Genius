import 'package:email_validator/email_validator.dart'; // Package for email validation
import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Flutter material package
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI
import 'package:flutter_svg/flutter_svg.dart'; // For SVG image support
import 'package:quiz_genius/firebase/auth.dart'; // Custom authentication class
import 'package:quiz_genius/models/current_user.dart'; // User model
import 'package:quiz_genius/utils/my_route.dart'; // Route management
import 'package:velocity_x/velocity_x.dart'; // Utility package for Flutter

import 'package:quiz_genius/utils/colors.dart'; // Custom colors for the app

// SignUp page widget
// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key); // Constructor for SignUp

  static final _formkey = GlobalKey<FormState>(); // Global key for form state

  @override
  State<SignUp> createState() => _SignUpState(); // Create the state for SignUp
}

class _SignUpState extends State<SignUp> {
  // Text controllers for email and password input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isVisible = true;
  Future<String> signUpUser(BuildContext context) async {
    String email = emailController.text; // Get email from controller
    String password = passwordController.text; // Get password from controller
    return await Auth(FirebaseAuth.instance)
        .signUp(email: email, password: password, context: context); // Call the signUp method
  }

  // Function to move to user page after sign-up
  moveToUserPage(BuildContext context) async {
    if (SignUp._formkey.currentState!.validate()) { // Validate form fields
      String email = emailController.text; // Get email
      String password = passwordController.text; // Get password
      SignUp._formkey.currentState!.save(); // Save form state
      // Store current user information
      CurrentUser.currentUser = UserName(email: email, password: password);
      print('sign up: name ${email} pass ${password}');
      String ans = await signUpUser(context); // Attempt to sign up the user
      if (ans == "Signup Complete")
        Navigator.pushReplacementNamed(context, MyRoutes.usernameRoute); // Navigate to username route on success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,  // Set background color
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Set app bar color
         leading: IconButton(
                onPressed: () {
                  // Navigates back to the previous screen
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.back),
              ),
        title: Center(
          child: Text(
            "SignUp Page", // Title of the page
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: SignUp._formkey, // Assign the form key
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h), // Spacing
            // Display SVG asset for visual appeal
            SvgPicture.asset(
              "assets/images/login.svg",
              fit: BoxFit.contain,
              width: (393 / 1.2).w,
            ).centered().py(24.sp),
            SizedBox(height: 20.h), // Spacing
            // Page heading
            "SignUp to Quiz Genius"
                .text
                .xl2
                .color(Theme.of(context).colorScheme.secondary,)
                .bold
                .center
                .makeCentered(),
            SizedBox(height: 20.h), // Spacing
            // Email input field
            Container(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 10.sp),
              decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor, // Input field background color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp),
                  )),
              child: TextFormField(
                controller: emailController, // Bind email controller
                decoration: InputDecoration(
                  hintText: "eg: abcd@gmail.com", // Hint for email input
                  hintStyle: TextStyle(
                    color: Colors.deepPurple.withOpacity(0.4), // Hint text color
                  ),
                  labelText: "Email", // Label for email input
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty"; // Validation message
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Email is invalid"; // Validation message for invalid email
                  }
                  return null; // Return null if valid
                },
              ),
            ).px(16.sp), // Padding for the container
            // Password input field
            Container(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 10.sp),
              decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor, // Input field background color
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.sp),
                    bottomRight: Radius.circular(20.sp),
                  )),
              child: TextFormField(
                obscureText: isVisible,
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "eg: 123456",
                    hintStyle: TextStyle(
                      color: Colors.deepPurple.withOpacity(0.4),
                    ),
                    labelText: "Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility_off
                            : Icons.visibility))),

                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty"; // Validation message
                  } else if (value.length < 6) {
                    return "Password length should be at least 6"; // Validation message for short password
                  }
                  return null; // Return null if valid
                },
              ).pOnly(bottom: 10.sp),
            ).px(16.sp), // Padding for the container
            SizedBox(height: 10.h), // Spacing
            Padding(
              padding: const EdgeInsets.only(left: 120, right: 120),
              child: OverflowBar(
                children: [
                  // Sign Up button
                  ElevatedButton(
                    onPressed: () {
                      moveToUserPage(context); // Call function to handle sign up
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Theme.of(context).colorScheme.primary,), // Button color
                      elevation: WidgetStateProperty.all(10), // Button elevation
                      side: WidgetStateProperty.all(
                           BorderSide(color: Theme.of(context).colorScheme.onPrimary,)), // Button border
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.sp), // Rounded corners
                        ),
                      ),
                    ),
                    child: Center(
                        child:  Text(
                      "Sign Up", // Button text
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold), // Button text style
                    )),
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

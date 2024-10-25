import 'package:email_validator/email_validator.dart'; // Package to validate email addresses
import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication package
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI
import 'package:flutter_svg/flutter_svg.dart'; // To display SVG images
import 'package:quiz_genius/firebase/auth.dart'; // Custom authentication class
import 'package:quiz_genius/models/current_user.dart'; // Model to handle current user details
import 'package:quiz_genius/utils/my_route.dart'; // Custom route definitions
import 'package:velocity_x/velocity_x.dart'; // For faster UI development with Vx

import 'package:quiz_genius/utils/colors.dart'; // Custom color utilities

// Login widget as a StatefulWidget to manage state
class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  // Global key to handle form validation
  static final _formkey = GlobalKey<FormState>();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controllers to capture input for email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Method to handle navigation to home after successful login
  moveToHome(BuildContext context) async {
    // Setting the current user with email and password from input fields
    CurrentUser.currentUser = UserName(
        email: emailController.text, password: passwordController.text);
    
    // Print email for debugging purposes
    print("email ${emailController.text} ");
    
    // Signing in using Firebase authentication
    String ans = await Auth(FirebaseAuth.instance).signIn(
        email: CurrentUser.currentUser.email,
        password: CurrentUser.currentUser.password,
        context: context);
    
    // If sign-in is successful, navigate to home screen
    if (ans == "SignIn Complete") {
      Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan, // Background color for the scaffold
      appBar: AppBar(
        backgroundColor: MyColors.mint, // AppBar background color
        title: const Center(
          child: Text(
            "Login Page", // AppBar title
            textAlign: TextAlign.center, // Center align title
          ),
        ),
      ),
      body: SingleChildScrollView( // Allows the page to scroll when content exceeds screen height
          child: Form(
        key: Login._formkey, // Assign form key for validation
        child: Column(
          children: [
            SizedBox(
              height: 20.h, // Adding space between elements
            ),
            // Display login SVG image at the top
            SvgPicture.asset(
              "assets/images/login.svg",
              fit: BoxFit.contain, // Make sure the SVG fits properly
              width: 393.w / 1.2, // Set width responsive to screen size
            ).centered().py(24.sp), // Add padding and center the image
            SizedBox(
              height: 20.h, // Space after the image
            ),
            // Welcome text styled and centered
            "Welcome to Quiz Genius"
                .text
                .xl2 // Set text size
                .color(MyColors.malachite) // Set text color
                .bold // Make the text bold
                .center // Center the text
                .makeCentered(),
            SizedBox(
              height: 20.h, // Space after the welcome text
            ),
            // Email input field with rounded borders at the top
            Container(
              padding:
                  EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 10.sp), // Padding around the text field
              decoration: BoxDecoration(
                  color: MyColors.elfGreen.withOpacity(0.6), // Semi-transparent green background
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp),
                  )),
              child: TextFormField(
                // Input decoration for the email field
                decoration: InputDecoration(
                  hintText: "eg: abcd@gmail.com", // Placeholder text
                  hintStyle: TextStyle(
                    color: Colors.deepPurple.withOpacity(0.4), // Hint text color
                  ),
                  labelText: "Email", // Label for the text field
                ),
                // Validation logic for the email field
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty"; // Error if empty
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Email is invalid"; // Error if not valid email
                  }
                  return null; // No error
                },
                controller: emailController, // Controller for the email input
              ),
            ).px(16.sp), // Horizontal padding
            // Password input field with rounded borders at the bottom
            Container(
              padding:
                  EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 10.sp),
              decoration: BoxDecoration(
                  color: MyColors.elfGreen.withOpacity(0.6), // Semi-transparent green background
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.sp),
                    bottomRight: Radius.circular(20.sp),
                  )),
              child: TextFormField(
                // Input decoration for the password field
                decoration: InputDecoration(
                  hintText: "eg: 123456", // Placeholder text
                  hintStyle: TextStyle(
                    color: Colors.deepPurple.withOpacity(0.4), // Hint text color
                  ),
                  labelText: "Password", // Label for the password field
                ),
                // Validation logic for the password field
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty"; // Error if empty
                  } else if (value.length < 6) {
                    return "Password length should be at least 6 characters"; // Error if too short
                  }
                  return null; // No error
                },
                controller: passwordController, // Controller for the password input
              ).pOnly(bottom: 10.sp), // Padding below the password field
            ).px(16.sp), // Horizontal padding
            SizedBox(
              height: 10.h, // Space after the password field
            ),
            // Row of buttons (Login and Sign Up)
            OverflowBar(
              children: [
                // Login button
                ElevatedButton(
                  onPressed: () {
                    // If form is validated, trigger moveToHome
                    if (Login._formkey.currentState!.validate()) {
                      moveToHome(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(MyColors.malachite), // Button color
                    elevation: WidgetStateProperty.all(10), // Button elevation (shadow)
                    side: WidgetStateProperty.all(
                        const BorderSide(color: Colors.white)), // Button border
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp), // Rounded corners
                      ),
                    ),
                  ),
                  child: const Text(
                    "Login", // Button text
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold), // Text styling
                  ),
                ),
                // Sign Up button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, MyRoutes.signUpRoute); // Navigate to SignUp page
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(MyColors.mint), // Button color
                    elevation: WidgetStateProperty.all(10), // Button elevation (shadow)
                    side: WidgetStateProperty.all(
                        const BorderSide(color: Colors.white)), // Button border
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp), // Rounded corners
                      ),
                    ),
                  ),
                  child: const Text("Sign Up",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                )
              ],
            ).px(16.sp) // Horizontal padding for button row
          ],
        ),
      )),
    );
  }
}

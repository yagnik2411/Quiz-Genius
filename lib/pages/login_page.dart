import 'package:flutter/material.dart';
import 'package:quiz_genius/utils/colors.dart';

class Login extends StatelessWidget {
   const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.lime,
      body: Center(
        child: Text(
          "Login Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

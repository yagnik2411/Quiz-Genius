import 'package:flutter/material.dart';
import 'package:quiz_genius/main.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class UserName extends StatelessWidget {
  UserName({super.key});

  late String _username;

  moveToHome(BuildContext context) {
    CurretUser.currentUser.setUserName(_username); 
     CurretUser.currentUser.add(context: context);
    Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      body: Center(
        child: Container(
          height:height / 5,
          width: width / 1.3,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: MyColors.elfGreen,
                blurRadius: 25,
                offset: Offset(0, 0),
                blurStyle: BlurStyle.outer,
              ),
            ],
            border: Border.all(
              color: MyColors.darkCyan,
              width: 2,
            ),
            color: MyColors.seaGreen,
            borderRadius: BorderRadius.circular(correctSize(20)),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              onChanged: (value) {
                _username = value;
              },
              decoration: InputDecoration(
                hintText: "eg: abc123",
                hintStyle: TextStyle(
                  color: Colors.deepPurple.withOpacity(0.4),
                ),
                labelText: "Username",
              ),
            ).px(correctSize(16)),
            ElevatedButton(
              onPressed: () {
                moveToHome(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors.mint),
                elevation: MaterialStateProperty.all(10),
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.white)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(correctSize(15)),
                  ),
                ),
              ),
              child: const Text("Sign in"),
            ).px(correctSize(12)),
          ]),
        ),
      ),
    );
  }
}

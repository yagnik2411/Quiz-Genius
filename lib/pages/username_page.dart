import 'package:flutter/material.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width / 1.3,
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
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "eg: abc123",
                hintStyle: TextStyle(
                  color: Colors.deepPurple.withOpacity(0.4),
                ),
                labelText: "Username",
              ),
            ).px16(),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors.mint),
                elevation: MaterialStateProperty.all(10),
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.white)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: const Text("Sign in"),
            ).px12(),
          ]),
        ),
      ),
    );
  }
}

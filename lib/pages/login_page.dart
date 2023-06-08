import 'package:flutter/material.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      appBar: AppBar(
        backgroundColor: MyColors.mint,
        title: Center(
          child: Text(
            "Login Page",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset(
              "assets/images/login.svg",
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width / 1.2,
            ).centered().py24(),
            const SizedBox(
              height: 20,
            ),
            "Welcome to Quiz Genius"
                .text
                .xl2
                .color(MyColors.malachite)
                .bold
                .center
                .makeCentered(),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding:  EdgeInsets.only(left: 20,right: 20,bottom: 10),
              decoration: BoxDecoration(
                color: MyColors.elfGreen.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  
                  hintText: "eg: abcd@gmail.com",
                  hintStyle: TextStyle(color: Colors.deepPurple.withOpacity(0.4),),
                  labelText: "Email",
                ),
              ),
              
            ).px16(),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              decoration: BoxDecoration(
                color: MyColors.elfGreen.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "eg: 123456",
                  hintStyle: TextStyle(
                    color: Colors.deepPurple.withOpacity(0.4),
                  ),
                  labelText: "Password",
                ),
              ),
            ).px16(),
          ],
        ),
      ),
    );
  }
}

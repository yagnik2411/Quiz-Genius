import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  final String name = "Yagnik";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      appBar: AppBar(
        backgroundColor: MyColors.mint,
        title: const Text("Quiz Genius").centered(),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              child: SvgPicture.asset(
                "assets/images/online_test.svg",
                fit: BoxFit.contain,
                height: 45,
                width: 45,
              ),
              radius: 50,
              backgroundColor: MyColors.darkCyan,
            ).p16(),
            Text("Welcome, $name")
                .text
                .xl3
                .color(MyColors.malachite)
                .bold
                .make()
                .p16(),
            Divider(
              color: MyColors.darkCyan,
              thickness: 1,
              // indent: 20,
              // endIndent: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors.darkCyan),
                elevation: MaterialStateProperty.all(10),
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.white)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "New Quiz",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )
                  ).centered()),
            ).px12(),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors.darkCyan),
                elevation: MaterialStateProperty.all(10),
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.white)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Text("Previous Scores",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )).centered()),
            ).px12(),
          ],
        ),
      ),
      drawer: Drawer(
        elevation: 10.0,
        backgroundColor: MyColors.elfGreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: SvgPicture.asset(
                        "assets/images/online_test.svg",
                        fit: BoxFit.contain,
                        height: 45,
                        width: 45,
                      ),
                      radius: 50,
                      backgroundColor: MyColors.lightLime,
                    ).p16(),
                    Text("Hello, $name")
                        .text
                        .xl3
                        .color(MyColors.malachite)
                        .bold
                        .make()
                        .p16(),
                  ],
                )).px16().py(8),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.profile_circled,
                  color: MyColors.malachite,
                  fill: 0.6,
                ),
                title: Text(
                  "Profile",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    color: MyColors.malachite,
                  ),
                ),
                onTap: () {},
              ),
            ).px16().py(5),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: ListTile(
                leading: Icon(
                  Icons.question_answer_outlined,
                  color: MyColors.malachite,
                  fill: 0.6,
                ),
                title: Text(
                  "New Quiz",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    color: MyColors.malachite,
                  ),
                ),
                onTap: () {},
              ),
            ).px16().py(5),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.question_circle_fill,
                  color: MyColors.malachite,
                  fill: 0.6,
                ),
                title: Text(
                  "Last Quiz",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    color: MyColors.malachite,
                  ),
                ),
                onTap: () {},
              ),
            ).px16().py(5),
          ],
        ),
      ),
    );
  }
}

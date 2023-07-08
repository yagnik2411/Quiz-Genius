import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:quiz_genius/utils/my_route.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                    radius: 50,
                    backgroundColor: MyColors.darkCyan,
                    child: SvgPicture.asset(
                      "assets/images/online_test.svg",
                      fit: BoxFit.contain,
                      height: 45,
                      width: 45,
                    ),
                  ).p16(),
                  Text("Welcome, $name")
                      .text
                      .xl3
                      .color(MyColors.malachite)
                      .bold
                      .make()
                      .p16(),
                  const Divider(
                    color: MyColors.darkCyan,
                    thickness: 1,
                    // indent: 20,
                    // endIndent: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.quizRoute);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MyColors.darkCyan),
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
                        child: const Text("New Quiz",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            )).centered()),
                  ).px12(),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.scoreRoute);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MyColors.darkCyan),
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
                        child: const Text("Previous Scores",
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
                            radius: 50,
                            backgroundColor: MyColors.lightLime,
                            child: SvgPicture.asset(
                              "assets/images/online_test.svg",
                              fit: BoxFit.contain,
                              height: 45,
                              width: 45,
                            ),
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
                      leading: const Icon(
                        CupertinoIcons.profile_circled,
                        color: MyColors.malachite,
                        fill: 0.6,
                      ),
                      title: const Text(
                        "Profile",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          color: MyColors.malachite,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.profileRoute);
                      },
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
                      leading: const Icon(
                        Icons.question_answer_outlined,
                        color: MyColors.malachite,
                        fill: 0.6,
                      ),
                      title: const Text(
                        "New Quiz",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          color: MyColors.malachite,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.quizRoute);
                      },
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
                      leading: const Icon(
                        CupertinoIcons.question_circle_fill,
                        color: MyColors.malachite,
                        fill: 0.6,
                      ),
                      title: const Text(
                        "Last Quiz",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          color: MyColors.malachite,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, MyRoutes.previousQuizRoute);
                      },
                    ),
                  ).px16().py(5),
                ],
              ),
            ),
          );
        } else {
          return Container(
            decoration: const BoxDecoration(
              color: MyColors.lightCyan,
            ),
            child: const Center(
                child: CircularProgressIndicator(
              color: MyColors.malachite,
              backgroundColor: MyColors.lightCyan,
            )),
          );
        }
      },
    );
  }

  _fetch() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(CurretUser.currentUser.email)
        .get()
        .then((ds) {
      name = ds['userName'];
      CurretUser.currentUser.performance = ds['performance'];
    }).catchError((e) {});
  }
}

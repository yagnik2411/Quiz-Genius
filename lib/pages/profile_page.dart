import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz_genius/main.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _user = "";
  int _performance = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userDataFetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: MyColors.lightCyan,
              appBar: AppBar(
                backgroundColor: MyColors.mint,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.back),
                ),
                title: const Text("Quiz Genius").centered(),
              ),
              body: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: correctSize(200),
                        width: correctSize(200),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: MyColors.malachite, width: 2),
                          borderRadius: BorderRadius.circular(correctSize(40)),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.2),
                              radius: correctSize(65),
                              child: SvgPicture.asset(
                                "assets/images/online_test.svg",
                                fit: BoxFit.contain,
                                height: correctSize(45),
                                width: correctSize(45),
                              ),
                            ).p(correctSize(10)),
                            Text(
                              "$_user",
                              style: TextStyle(
                                fontSize: correctSize(25),
                                color: MyColors.darkCyan,
                              ),
                            )
                          ],
                        ),
                      ).pOnly(right: correctSize(5)),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.malachite, width: 2),
                      borderRadius: BorderRadius.circular(correctSize(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Performance",
                          style: TextStyle(
                            fontSize: correctSize(40),
                            color: MyColors.darkCyan,
                          ),
                        ),
                        SizedBox(
                          height: correctSize(30),
                        ),
                        CircularPercentIndicator(
                          radius: correctSize(150),
                          percent: _performance/100,
                          lineWidth: correctSize(20),
                          animateFromLastPercent: true,
                          progressColor: MyColors.mint,
                          backgroundColor: MyColors.mint.withOpacity(0.4),
                          animation: true,
                          animationDuration: 2000,
                          rotateLinearGradient: true,
                          circularStrokeCap: CircularStrokeCap.round,
                          curve: Curves.easeInOutCirc,
                          center: Text(
                            "$_performance%",
                            style: TextStyle(
                              fontSize: correctSize(60),
                              color: MyColors.darkCyan,
                            ),
                          ),
                        )
                      ],
                    ),
                  ).pOnly(top: correctSize(10)).expand()
                ],
              ).pOnly(top: correctSize(20), right: correctSize(10), left: correctSize(10), bottom: correctSize(20)),
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
        });
  }

  userDataFetch() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(CurretUser.currentUser.email)
        .get()
        .then((data) {
      _user = data['userName'];
      _performance = data['performance'];
    });
  }
}

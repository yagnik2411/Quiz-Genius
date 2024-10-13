import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_genius/firebase/auth.dart';
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
                    radius: 50.w,
                    backgroundColor: MyColors.darkCyan,
                    child: SvgPicture.asset(
                      "assets/images/online_test.svg",
                      fit: BoxFit.contain,
                      height: 45.h,
                      width: 45.w,
                    ),
                  ).p(16.sp),
                  Text("Welcome, ${CurrentUser.currentUser.userName}")
                      .text
                      .xl3
                      .color(MyColors.malachite)
                      .bold
                      .make()
                      .p(16.sp),
                  Divider(
                    color: MyColors.darkCyan,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 20.h,
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
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                      ),
                    ),
                    child: Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        child: Text("New Quiz",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                            )).centered()),
                  ).px(12.sp),
                  SizedBox(
                    height: 10.h,
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
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                      ),
                    ),
                    child: Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        child: Text("Previous Scores",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                            )).centered()),
                  ).px(12.sp),
                  // Text("For new users: Actual scores will be calculated from the second quiz onwards; the first quiz was a demo.")
                  //     .text
                  //     .color(MyColors.malachite)
                  //     .bold
                  //     .make().p(12.sp)
                ],
              ),
            ),
            drawer: Drawer(
              elevation: 10.0,
              backgroundColor: MyColors.elfGreen,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                      height: 200.h,
                      width: 393.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50.w,
                              backgroundColor: MyColors.darkCyan,
                              backgroundImage: NetworkImage(
                                  CurrentUser.currentUser.profileImage),
                              // Use this line to set the image
                              child:
                                  CurrentUser.currentUser.profileImage.isEmpty
                                      ? SvgPicture.asset(
                                          "assets/images/online_test.svg",
                                          fit: BoxFit.contain,
                                          height: 45.h,
                                          width: 45.w,
                                        )
                                      : null,
                            ),
                            Text("Hello, ${CurrentUser.currentUser.userName}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,)
                                .text
                                .xl3
                                .color(MyColors.malachite)
                                .bold
                                .make()
                                .p(16.sp),
                          ],
                        ),
                      )).px(16.sp).py(8.sp),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        alignment: Alignment.center,
                        child: ListTile(
                          leading: const Icon(
                            CupertinoIcons.profile_circled,
                            color: MyColors.malachite,
                            fill: 0.6,
                          ),
                          title: Text(
                            "Profile",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: MyColors.malachite,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, MyRoutes.profileRoute);
                          },
                        ),
                      ).px(16.sp).py(5.sp),
                      Container(
                        height: 60.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        alignment: Alignment.center,
                        child: ListTile(
                          leading: const Icon(
                            Icons.question_answer_outlined,
                            color: MyColors.malachite,
                            fill: 0.6,
                          ),
                          title: Text(
                            "New Quiz",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: MyColors.malachite,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, MyRoutes.quizRoute);
                          },
                        ),
                      ).px(16.sp).py(5.sp),
                      Container(
                        height: 60.h,
                        width: 393.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        alignment: Alignment.center,
                        child: ListTile(
                          leading: const Icon(
                            CupertinoIcons.question_circle_fill,
                            color: MyColors.malachite,
                            fill: 0.6,
                          ),
                          title: Text(
                            "Last Quiz",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: MyColors.malachite,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, MyRoutes.previousQuizRoute);
                          },
                        ),
                      ).px16().py(5),
                      Container(
                        height: 60.h,
                        width: 393.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        alignment: Alignment.center,
                        child: ListTile(
                          leading: const Icon(
                            CupertinoIcons.arrow_left_square_fill,
                            color: MyColors.malachite,
                            fill: 0.6,
                          ),
                          title: Text(
                            "Sign Out",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: MyColors.malachite,
                            ),
                          ),
                          onTap: () {
                            Auth(FirebaseAuth.instance)
                                .signOut(context: context);
                          },
                        ),
                      ).px16().py(5),
                    ],
                  )
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
        .doc(CurrentUser.currentUser.email)
        .get()
        .then((ds) {
      CurrentUser.currentUser.userName = ds['userName'];
      print(name);
      CurrentUser.currentUser.performance = ds['performance'];
    }).catchError((e) {});
  }
}

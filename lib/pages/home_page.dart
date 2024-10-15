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
  String? profileImageUrl;

  confirmSignOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 10,
              shadowColor: Colors.grey.shade700,
              content: Container(
                  height: 210.h,
                  width: 393.w,
                  padding: const EdgeInsets.all(15.0),
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      gradient: new LinearGradient(
                          colors: [
                            MyColors.lightCyan,
                            Colors.white,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Sign Out")
                          .text
                          .xl3
                          .color(MyColors.darkCyan)
                          .bold
                          .make(),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Do you really want to sign out from the app?',
                        style:
                            TextStyle(fontSize: 16, color: MyColors.darkCyan),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(MyColors.darkCyan),
                                  elevation: WidgetStatePropertyAll(10),
                                  side: WidgetStatePropertyAll(
                                      const BorderSide(color: Colors.white)),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.sp))),
                                ),
                                child: Container(
                                  height: 50.h,
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.white),
                                  ).centered(),
                                )),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  Auth(FirebaseAuth.instance)
                                      .signOut(context: context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(MyColors.darkCyan),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.sp))),
                                  side: WidgetStatePropertyAll(
                                      const BorderSide(color: Colors.white)),
                                  elevation: WidgetStatePropertyAll(10),
                                ),
                                child: Container(
                                  height: 50.sp,
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.white),
                                  ).centered(),
                                )),
                          )
                        ],
                      )
                    ],
                  )),
              contentPadding: EdgeInsets.all(0.0),
            ));
  }

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
              title: Text(
                "Quiz Genius",
                style: Theme.of(context).textTheme.titleMedium,
              ).centered(),
            ),
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                                "Welcome,\n${CurrentUser.currentUser.userName}")
                            .text
                            .xl3
                            .color(MyColors.malachite)
                            .bold
                            .make()
                            .p(16.sp),
                      ),
                      Expanded(
                        child: CircleAvatar(
                          radius: 50.w,
                          backgroundColor: MyColors.darkCyan,
                          backgroundImage: NetworkImage(
                              CurrentUser.currentUser.profileImage),
                          // Use this line to set the image
                          child: CurrentUser.currentUser.profileImage.isEmpty
                              ? SvgPicture.asset(
                                  "assets/images/online_test.svg",
                                  fit: BoxFit.contain,
                                  height: 45.h,
                                  width: 45.w,
                                )
                              : null,
                        ).p(16.sp),
                      ),
                    ],
                  ),
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
                          WidgetStateProperty.all(MyColors.darkCyan),
                      elevation: WidgetStateProperty.all(10),
                      side: WidgetStateProperty.all(
                          const BorderSide(color: Colors.white)),
                      shape: WidgetStateProperty.all(
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
                          WidgetStateProperty.all(MyColors.darkCyan),
                      elevation: WidgetStateProperty.all(10),
                      side: WidgetStateProperty.all(
                          const BorderSide(color: Colors.white)),
                      shape: WidgetStateProperty.all(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40.w,
                            backgroundColor: MyColors.lightLime,
                            child: SvgPicture.asset(
                              "assets/images/online_test.svg",
                              fit: BoxFit.contain,
                              height: 45.w,
                              width: 45.w,
                            ),
                          ).p(10.sp),
                          Text("Hello, ${CurrentUser.currentUser.userName.trim()}")
                              .text
                              .xl3
                              .color(MyColors.malachite)
                              .bold
                              .make()
                              .p(16.sp),
                        ],
                      )).px(16.sp).py(8.sp),
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
                        Navigator.pushNamed(context, MyRoutes.profileRoute);
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
                        Navigator.pushNamed(context, MyRoutes.quizRoute);
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
                        confirmSignOut(context);
                        // Auth(FirebaseAuth.instance).signOut(context: context);
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
    //Fetch user data from Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(CurrentUser.currentUser.email)
        .get()
        .then((ds) {
      CurrentUser.currentUser.userName = ds['userName'];
      print(name);
      CurrentUser.currentUser.performance = ds['performance'];
      CurrentUser.currentUser.profileImage = ds['profileImage'];
      profileImageUrl = CurrentUser.currentUser.profileImage;
    }).catchError((e) {});
  }
}

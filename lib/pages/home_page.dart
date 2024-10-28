import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_genius/firebase/auth.dart';
import 'package:quiz_genius/pages/quiz_mcq_page.dart';
import 'package:quiz_genius/pages/quiz_page.dart';
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
      future: _fetch(), // Fetching user data asynchronously
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
                  Divider(color: MyColors.darkCyan, thickness: 1),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () => showDiffMenu(context), // Show difficulty selection
                    style: _buttonStyle(),
                    child: _buttonContent("New Quiz", context),
                  ).px(12.sp),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, MyRoutes.scoreRoute),
                    style: _buttonStyle(),
                    child: _buttonContent("Previous Scores", context),
                  ).px(12.sp),
                  // Text("For new users: Actual scores will be calculated from the second quiz onwards; the first quiz was a demo.")
                  //     .text
                  //     .color(MyColors.malachite)
                  //     .bold
                  //     .make().p(12.sp)
                ],
              ),
            ),
            // drawer: Drawer(
            //   elevation: 10.0,
            //   backgroundColor: MyColors.elfGreen,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         height: 50.h,
            //       ),
            //       Container(
            //           height: 200.h,
            //           width: 393.w,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(20.sp),
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Expanded(
            //                 flex: 1,
            //                 child: CircleAvatar(
            //                   radius: 40.w,
            //                   backgroundColor: MyColors.lightLime,
            //                   child: SvgPicture.asset(
            //                     "assets/images/online_test.svg",
            //                     fit: BoxFit.contain,
            //                     height: 45.w,
            //                     width: 45.w,
            //                   ),
                            ).p(10.sp),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text("Hello, \n${CurrentUser.currentUser.userName.trim()}")
                                .text
                                .xl3
                                .color(MyColors.malachite)
                                .bold
                                .make()
                                .p(16.sp),
                          ),
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Sign Out"),
                              content: const Text(
                                  "Do you really want to sign out from the app?"),
                              actions: [
                                TextButton(
                                  child: const Text("No"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                                TextButton(
                                  child: const Text("Yes"),
                                  onPressed: () {
                                    Auth(FirebaseAuth.instance)
                                        .signOut(context: context);
                                    Navigator.of(context)
                                        .pop(); // Close the dialog after sign out
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ).px16().py(5),
                ],
              ),
            ),
       // Drawer for navigation
          );
        } else {
          return _loadingScreen(); // Show loading indicator
        }
      },
    );
  }

  _fetch() async {
    // Fetch user data from Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(CurrentUser.currentUser.email)
        .get()
        .then((ds) {
      CurrentUser.currentUser.userName = ds['userName'];
      CurrentUser.currentUser.performance = ds['performance'];
    }).catchError((e) {});
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(MyColors.darkCyan),
      elevation: WidgetStateProperty.all(10),
      side: WidgetStateProperty.all(BorderSide(color: Colors.white)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
      ),
    );
  }

  Widget _buttonContent(String text, BuildContext context) {
    return Container(
      height: 50.h,
      width: MediaQuery.of(context).size.width,
      child: Text(text, style: TextStyle(fontSize: 20.sp, color: Colors.white)).centered(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      backgroundColor: MyColors.elfGreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50.h),
          _drawerHeader(),
          _drawerItem(CupertinoIcons.profile_circled, "Profile", MyRoutes.profileRoute, context),
          _drawerItem(Icons.question_answer_outlined, "New Quiz", MyRoutes.quizRoute, context),
          _drawerItem(CupertinoIcons.question_circle_fill, "Last Quiz", MyRoutes.previousQuizRoute, context),
          _drawerItem(CupertinoIcons.arrow_left_square_fill, "Sign Out", null, context,
              onTap: () => Auth(FirebaseAuth.instance).signOut(context: context)),
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return Container(
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
      ),
    ).px(16.sp).py(8.sp);
  }

  Widget _drawerItem(IconData icon, String label, String? route, BuildContext context, {Function? onTap}) {
    return Container(
      height: 60.h,
      width: 393.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: ListTile(
        leading: Icon(icon, color: MyColors.malachite),
        title: Text(label, style: TextStyle(fontSize: 20.sp, color: MyColors.malachite)),
        onTap: onTap != null
            ? () => onTap()
            : () => Navigator.pushNamed(context, route!),
      ),
    ).px(16.sp).py(5.sp);
  }

  Widget _loadingScreen() {
    return Container(
      color: MyColors.lightCyan,
      child: Center(
        child: CircularProgressIndicator(
          color: MyColors.malachite,
          backgroundColor: MyColors.lightCyan,
        ),
      ),
    );
  }
}

void showDiffMenu(BuildContext context) {
  // Difficulty selection menu
  showDialog(
    context: context,
    builder: (context) {
      return _buildDialog(
        "Select Difficulty Type",
        [
          _dialogOption("Easy", () {
            Navigator.pop(context);
            showQuizMenu(context, "easy");
          }),
          _dialogOption("Medium", () {
            Navigator.pop(context);
            showQuizMenu(context, "medium");
          }),
          _dialogOption("Hard", () {
            Navigator.pop(context);
            showQuizMenu(context, "hard");
          }),
        ],
      );
    },
  );
}

void showQuizMenu(BuildContext context, String difficulty) {
  // Quiz type selection menu
  showDialog(
    context: context,
    builder: (context) {
      return _buildDialog(
        "Select Quiz Type",
        [
          _dialogOption("True/False Quiz", () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => QuizPage(difficulty: difficulty)));
          }),
          _dialogOption("MCQ Quiz", () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => QuizMCQPage(difficulty: difficulty)));
          }),
        ],
      );
    },
  );
}

Widget _buildDialog(String title, List<Widget> options) {
  return AlertDialog(
    backgroundColor: MyColors.lightCyan,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
    title: Text(title, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
    content: Column(mainAxisSize: MainAxisSize.min, children: options),
  );
}

Widget _dialogOption(String text, VoidCallback onTap) {
  return ListTile(
    title: Text(text, style: TextStyle(color: Colors.black87)),
    onTap: onTap,
  );
}

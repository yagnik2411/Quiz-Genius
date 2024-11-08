import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_genius/firebase/auth.dart';
import 'package:quiz_genius/main.dart';
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
            backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              //backgroundColor: MyColors.mint,
              title: const Text("Quiz Genius").centered(),
               actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (_, currentTheme, __) {
              return IconButton(
                icon: Icon(
                  currentTheme == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: () {
                  // Toggle theme between light and dark
                  themeNotifier.value =
                      currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                },
              );
            },
          ),
        ],
            ),
            body: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.w,
                    backgroundColor:  Theme.of(context).colorScheme.secondary,
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
                      .color(Theme.of(context).colorScheme.secondary)
                      .bold
                      .make()
                      .p(16.sp),
                  Divider(color:Theme.of(context).colorScheme.primary, thickness: 1),
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
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              radius: 40.w,
                              backgroundColor: MyColors.lightLime,
                              child: SvgPicture.asset(
                                "assets/images/online_test.svg",
                                fit: BoxFit.contain,
                                height: 45.w,
                                width: 45.w,
                              ),
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
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              radius: 40.w,
                              backgroundColor: MyColors.lightLime,
                              child: SvgPicture.asset(
                                "assets/images/online_test.svg",
                                fit: BoxFit.contain,
                                height: 45.w,
                                width: 45.w,
                              ),
                            
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
                        Auth(FirebaseAuth.instance).signOut(context: context);
                      },
                    ),
                  ).px16().py(5),

                ],
              ),
            ),
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
      backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
      elevation: WidgetStateProperty.all(10),
      side: WidgetStateProperty.all(BorderSide(color: Theme.of(context).colorScheme.onPrimary)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
      ),
    );
  }

  Widget _buttonContent(String text, BuildContext context) {
    return Container(
      height: 50.h,
      width: MediaQuery.of(context).size.width,
      child: Text(text, style: TextStyle(fontSize: 20.sp, color: Theme.of(context).colorScheme.onPrimary)).centered(),
    );
  }

  Widget _loadingScreen() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
Widget _buildDialog(BuildContext context, String title, List<Widget> options) {
  return AlertDialog(
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
    title: Text(
      title,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
    content: Column(mainAxisSize: MainAxisSize.min, children: options),
  );
}

Widget _dialogOption(BuildContext context, String text, VoidCallback onTap) {
  return ListTile(
    title: Text(
      text,
      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
    ),
    onTap: onTap,
  );
}

// Usage in showDiffMenu and showQuizMenu functions
void showDiffMenu(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return _buildDialog(
        context, // Pass context here
        "Select Difficulty Type",
        [
          _dialogOption(context, "Easy", () {
            Navigator.pop(context);
            showQuizMenu(context, "easy");
          }),
          _dialogOption(context, "Medium", () {
            Navigator.pop(context);
            showQuizMenu(context, "medium");
          }),
          _dialogOption(context, "Hard", () {
            Navigator.pop(context);
            showQuizMenu(context, "hard");
          }),
        ],
      );
    },
  );
}

void showQuizMenu(BuildContext context, String difficulty) {
  showDialog(
    context: context,
    builder: (context) {
      return _buildDialog(
        context, // Pass context here
        "Select Quiz Type",
        [
          _dialogOption(context, "True/False Quiz", () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => QuizPage(difficulty: difficulty)));
          }),
          _dialogOption(context, "MCQ Quiz", () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => QuizMCQPage(difficulty: difficulty)));
          }),
        ],
      );
    },
  );
}


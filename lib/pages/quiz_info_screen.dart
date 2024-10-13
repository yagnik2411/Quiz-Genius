import 'package:flutter/material.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:velocity_x/velocity_x.dart';

class QuizInfoScreen extends StatelessWidget {
  const QuizInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      appBar: AppBar(
        backgroundColor: MyColors.mint,
        title: const Text(
          "Quiz Information",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Quiz Genius!",
              style: TextStyle(
                color: MyColors.darkCyan,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ).py(10.sp),
            Text(
              "In this quiz, you will be asked a series of 10 questions. "
              "You need to choose between 'True' or 'False' for each question. "
              "Your performance will be calculated based on the number of correct answers you give.",
              style: TextStyle(
                color: MyColors.malachite,
                fontSize: 16.sp,
              ),
            ).py(10.sp),
            Text(
              "Rules:",
              style: TextStyle(
                color: MyColors.darkCyan,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ).py(10.sp),
            Text(
              "- Each correct answer will give you 10 points.\n"
              "- There is no negative marking.\n"
              "- You can only submit the quiz once.",
              style: TextStyle(
                color: MyColors.malachite,
                fontSize: 16.sp,
              ),
            ).py(10.sp),
            Text(
              "Good Luck!",
              style: TextStyle(
                color: MyColors.darkCyan,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ).py(10.sp),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.quizRoute);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(MyColors.mint),
                  elevation: WidgetStateProperty.all(10),
                  side: WidgetStateProperty.all(
                    const BorderSide(color: Colors.white, width: 2),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: MyColors.seashall,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/models/scores.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

/// The ScorePage widget is a StatefulWidget that displays the user's quiz scores.
class ScorePage extends StatefulWidget {
  ScorePage({Key? key}) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  /// Count variable to store the number of quiz scores available.
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        /// Fetch the scores from Firestore.
        future: scoreFetch(),
        builder: (context, snapshot) {
          /// Check if the Future is completed.
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    /// Navigate back to the previous screen when the back button is pressed.
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.back),
                ),
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                title: const Text("Quiz Genius").centered(),
              ),

              /// The body of the page shows either a list of quiz scores or a message.
              body: Container(
                height: (MediaQuery.of(context).size.height * 0.9).h,

                /// If there are no scores (count == 0), display a message.
                child: count == 0
                    ? Center(
                        child: Text("Give Your First Quiz")
                            .text
                            .xl3
                            .color(MyColors.malachite)
                            .bold
                            .make()
                            .p(16.sp),
                      )
                    :

                    /// Otherwise, display the list of quiz scores with a limit of 10.
                    ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.sp, horizontal: 16.sp),
                        itemCount: count > 10 ? 10 : count,
                        itemBuilder: (context, index) {
                          print(count);
                          return Container(
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: MyColors.darkCyan, width: 3.w),
                              borderRadius: BorderRadius.circular(15.sp),
                              color: MyColors.malachite.withOpacity(0.8),
                            ),

                            /// Display each quiz's date, correct answers, and percentage.
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quiz Date:${Scores.scores[index].date}",
                                  style: TextStyle(
                                    color: MyColors.seashall,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textWidthBasis: TextWidthBasis.parent,
                                ).px(12.sp).py(4.sp),
                                Divider(
                                  color: MyColors.darkCyan,
                                  thickness: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: MyColors.seashall,
                                    ).pOnly(left: 12.sp),
                                    Text(
                                      "Correct: ${Scores.scores[index].correct} ",
                                      style: TextStyle(
                                        color: MyColors.seashall,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textWidthBasis: TextWidthBasis.parent,
                                    ).py(4.sp).pOnly(right: 12.sp),
                                    const Spacer(),
                                    Text(
                                      "Percent: ${Scores.scores[index].scoreInPercent}% ",
                                      style: TextStyle(
                                        color: MyColors.seashall,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textWidthBasis: TextWidthBasis.parent,
                                    ).px(12.sp).py(4.sp),
                                  ],
                                )
                              ],
                            ),
                          ).py(5.sp);
                        }),
              ),
            );
          } else {
            /// If the data is still being fetched, show a loading indicator.
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

  /// This method fetches the user's previous quiz scores from Firestore.
  scoreFetch() async {
    /// Get the scores from Firestore for the current user.
    await FirebaseFirestore.instance
        .collection("users")
        .doc(CurrentUser.currentUser.email)
        .collection("previousScores")
        .doc("scores")
        .get()
        .then((data) {
      /// Extract the scores from the Firestore document and add them to the `Scores` list.
      List temp = data['scores'];
      for (int i = 0; i < temp.length; i++) {
        Scores.scores.add(Score(
            correct: data['scores'][i]['correct'],
            scoreInPercent: data['scores'][i]['scoreInPercent'],
            date: data['scores'][i]['date']));
      }

      /// Set the count to the number of scores.
      count = temp.length;
    }).catchError((e) {
      /// Handle any errors that may occur during data fetching.
      if (e is RangeError) {
        // Handle the RangeError exception.
        print('RangeError occurred: ${e.message}');
      }
    });
  }
}

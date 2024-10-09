import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/models/scores.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ScorePage extends StatefulWidget {
  ScorePage({Key? key}) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: scoreFetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: MyColors.lightCyan,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.back),
                ),
                backgroundColor: MyColors.mint,
                title: const Text("Quiz Genius").centered(),
              ),
              body: Container(
                height: (MediaQuery.of(context).size.height * 0.9).h,
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
                    : ListView.builder(
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
                                      "Prcent: ${Scores.scores[index].scoreInPercent}% ",
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

  scoreFetch() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(CurrentUser.currentUser.email)
        .collection("previousScores")
        .doc("scores")
        .get()
        .then((data) {
      List temp = data['scores'];
      for (int i = 0; i < temp.length; i++) {
        Scores.scores.add(Score(
            correct: data['scores'][i]['correct'],
            scoreInPercent: data['scores'][i]['scoreInPercent'],
            date: data['scores'][i]['date']));
      }
      count = temp.length;
    }).catchError((e) {
      if (e is RangeError) {
        // Handle the RangeError exception
        print('RangeError occurred: ${e.message}');
      }
    });
  }
}

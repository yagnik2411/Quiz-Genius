import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_genius/main.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/models/scores.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ScorePage extends StatelessWidget {
  ScorePage({Key? key}) : super(key: key);
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
                height: correctSize(height * 0.9),
                child: count == 0
                    ? Center(
                        child: Text("Give Your First Quiz")
                            .text
                            .xl3
                            .color(MyColors.malachite)
                            .bold
                            .make()
                            .p(correctSize(16)),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: correctSize(8),
                            horizontal: correctSize(16)),
                        itemCount: count > 10 ? 10 : count,
                        itemBuilder: (context, index) {
                          print(count);
                          return Container(
                            padding: EdgeInsets.all(correctSize(8)),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: MyColors.darkCyan,
                                  width: correctSize(3)),
                              borderRadius:
                                  BorderRadius.circular(correctSize(15)),
                              color: MyColors.malachite.withOpacity(0.8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quiz Date:${Scores.scores[index].date}",
                                  style: TextStyle(
                                    color: MyColors.seashall,
                                    fontSize: correctSize(20),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textWidthBasis: TextWidthBasis.parent,
                                ).px(correctSize(12)).py(correctSize(4)),
                                Divider(
                                  color: MyColors.darkCyan,
                                  thickness: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: MyColors.seashall,
                                    ).pOnly(left: correctSize(12)),
                                    Text(
                                      "Correct: ${Scores.scores[index].correct} ",
                                      style: TextStyle(
                                        color: MyColors.seashall,
                                        fontSize: correctSize(20),
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textWidthBasis: TextWidthBasis.parent,
                                    )
                                        .py(correctSize(4))
                                        .pOnly(right: correctSize(12)),
                                    const Spacer(),
                                    Text(
                                      "Prcent: ${Scores.scores[index].scoreInPercent}% ",
                                      style: TextStyle(
                                        color: MyColors.seashall,
                                        fontSize: correctSize(20),
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textWidthBasis: TextWidthBasis.parent,
                                    ).px(correctSize(12)).py(correctSize(4)),
                                  ],
                                )
                              ],
                            ),
                          ).py(correctSize(5));
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
        .doc(CurretUser.currentUser.email)
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

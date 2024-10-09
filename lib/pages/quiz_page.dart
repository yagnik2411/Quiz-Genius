import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/models/scores.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:quiz_genius/utils/toast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:quiz_genius/models/previous_questions.dart';
import 'package:quiz_genius/models/questions.dart';
import 'package:quiz_genius/utils/colors.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<List<Question>> quizFuture;
  List<bool> isAdd = List.generate(10, (i) => false);
  List<int> isCorrect = List.generate(10, (i) => -1);
  int correct = 0;
  bool isSubmitButtonDisabled = false; // Prevents multiple submissions

  @override
  void initState() {
    super.initState();
    quizFuture = Questions().getQuestions();
    PreviousQuestions.questions.clear(); // Clear previous questions for a new quiz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      appBar: AppBar(
        backgroundColor: MyColors.mint,
        title: const Center(
          child: Text(
            "Quiz Genius",
            textAlign: TextAlign.center,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Question>>(
        future: quizFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            final quiz = snapshot.data!;

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.darkCyan, width: 3),
                    borderRadius: BorderRadius.circular(15.sp),
                    color: MyColors.malachite.withOpacity(0.8),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          quiz[index].question,
                          style: TextStyle(
                            color: MyColors.seashall,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.values[5],
                          ),
                          textWidthBasis: TextWidthBasis.parent,
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        buttonPadding: EdgeInsets.symmetric(
                          horizontal: 20.sp,
                          vertical: 10.sp,
                        ),
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (!isAdd[index]) {
                                setState(() {
                                  isAdd[index] = true;
                                  if (quiz[index].answer == true) {
                                    isCorrect[index] = 0;
                                    toMassage(msg: "correct");
                                    correct++;
                                  } else {
                                    isCorrect[index] = 1;
                                    toMassage(msg: "incorrect");
                                  }

                                  // Add question to PreviousQuestions
                                  PreviousQuestions.questions.add(
                                    PreviousQuestion(
                                      id: index,
                                      question: quiz[index].question,
                                      correct: isCorrect[index] == 0,
                                    ),
                                  );
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: (isAdd[index] == false)
                                  ? MaterialStateProperty.all(MyColors.mint)
                                  : ((isCorrect[index] == 0)
                                      ? MaterialStateProperty.all(Colors.green)
                                      : MaterialStateProperty.all(Colors.red)),
                              elevation: MaterialStateProperty.all(10),
                              fixedSize: MaterialStateProperty.all(
                                Size(120.w, 40.h),
                              ),
                              side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.white),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                              ),
                            ),
                            child: "True".text.xl.make(),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (!isAdd[index]) {
                                setState(() {
                                  isAdd[index] = true;
                                  if (quiz[index].answer == false) {
                                    isCorrect[index] = 1;
                                    toMassage(msg: "correct");
                                    correct++;
                                  } else {
                                    isCorrect[index] = 0;
                                    toMassage(msg: "incorrect");
                                  }

                                  // Add question to PreviousQuestions
                                  PreviousQuestions.questions.add(
                                    PreviousQuestion(
                                      id: index,
                                      question: quiz[index].question,
                                      correct: isCorrect[index] == 1,
                                    ),
                                  );
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: (isAdd[index] == false)
                                  ? MaterialStateProperty.all(MyColors.mint)
                                  : ((isCorrect[index] == 1)
                                      ? MaterialStateProperty.all(Colors.green)
                                      : MaterialStateProperty.all(Colors.red)),
                              elevation: MaterialStateProperty.all(10),
                              fixedSize: MaterialStateProperty.all(
                                Size(120.w, 40.h),
                              ),
                              side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.white),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                              ),
                            ),
                            child: "False".text.xl.make(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).py(5.sp);
              },
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.malachite,
              MyColors.mint,
              MyColors.lightCyan,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
          child: ElevatedButton(
onPressed: isSubmitButtonDisabled
    ? null
    : () async {
        if (isAdd.contains(false)) {
          toMassage(msg: "Please answer all questions!");
          return;
        }

        bool confirm = await showSubmissionConfirmationDialog(context);

        // If confirmed, proceed with submission
        if (confirm) {
          setState(() {
            isSubmitButtonDisabled = true; // Disable submit button
          });

          await scoreUpdate(context);
          int currentPerformance = ((correct * 10) +
              CurrentUser.currentUser.performance) ~/ 2;

          CurrentUser.currentUser.performanceUpdate(
            context: context,
            currentEmail: CurrentUser.currentUser.email,
            currentPerformance: currentPerformance,
          );

          Scores.updateScores(
            context: context,
            score: Scores.scores,
            email: CurrentUser.currentUser.email,
          );

          // Add previous questions to Firestore
          PreviousQuestions.addToCollection(
            context: context,
            question: PreviousQuestions.questions,
            email: CurrentUser.currentUser.email,
          );

          Navigator.pushReplacementNamed(
            context,
            MyRoutes.homeRoute,
          );
        }
      },

            style: ButtonStyle(
              backgroundColor: isSubmitButtonDisabled
                  ? MaterialStateProperty.all(Colors.grey)
                  : MaterialStateProperty.all(MyColors.mint),
              elevation: MaterialStateProperty.all(10),
              side: MaterialStateProperty.all(
                const BorderSide(color: MyColors.seashall, width: 2),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
              ),
            ),
            child: "Submit".text.xl2.make(),
          ).p(12.sp),
        ),
      ),
    );
  }

  void scoreListAdd(BuildContext context) {
    // Add new score
    Scores.scores.add(Score(
      correct: correct,
      scoreInPercent: correct * 10,
      date: DateFormat('dd / MM / yyyy').format(DateTime.now()).toString(),
    ));

    // Keep only the last 10 scores
    if (Scores.scores.length > 10) {
      Scores.scores = Scores.scores.sublist(Scores.scores.length - 10);
    }

    // Update Firestore with the new scores
    Scores.addScores(
      context: context,
      score: Scores.scores,
      email: CurrentUser.currentUser.email,
    );
  }

  Future<void> scoreFetch() async {
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection("users")
        .doc(CurrentUser.currentUser.email)
        .collection("previousScores")
        .doc("scores");

    try {
      DocumentSnapshot data = await userDocRef.get();

      if (data.exists) {
        List temp = data['scores'];
        for (int i = 0; i < temp.length; i++) {
          Scores.scores.add(Score(
            correct: data['scores'][i]['correct'],
            scoreInPercent: data['scores'][i]['scoreInPercent'],
            date: data['scores'][i]['date'],
          ));
        }
      } else {
        await userDocRef.set({'scores': []});
      }
    } catch (e) {
      print("Error fetching scores: $e");
    }
  }

  Future<void> scoreUpdate(BuildContext context) async {
    Scores.scores.clear();
    await scoreFetch();
    scoreListAdd(context);
  }

  Future<bool> showSubmissionConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: MyColors.malachite
                  .withOpacity(0.9), // Set background color to match the theme
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    15.sp), // Rounded corners for consistency
              ),
              title: Text(
                "Confirm Submission",
                style: TextStyle(
                  color: MyColors.seashall, // Text color matching theme
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                "Are you sure you want to submit your quiz?",
                style: TextStyle(
                  color: MyColors.seashall,
                  fontSize: 16.sp,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Cancel submission
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: MyColors.mint, // Button color from the theme
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Confirm submission
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        MyColors.mint, // Button color matching theme
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: MyColors.seashall, // Button text color
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if the dialog is dismissed
  }
}

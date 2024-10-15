import 'dart:async'; // For Timer
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

class QuizMCQPage extends StatefulWidget {
  final String difficulty;

  const QuizMCQPage({Key? key, required this.difficulty}) : super(key: key);

  @override
  State<QuizMCQPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizMCQPage> {
  late Future<List<QuestionMCQ>> quizFuture;
  List<bool> isAdd = List.generate(10, (i) => false);
  List<int> isCorrect = List.generate(10, (i) => -1);
  int correct = 0;
  Timer? timer; // Declare a timer
  int remainingTime = 600; // 10 minutes in seconds
  // List<PreviousQuestions> previousQuestions = [];
  @override
  void initState() {
    super.initState();
    quizFuture = Questions().getMCQQuestions();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--; // Decrease the time
        });
      } else {
        timer.cancel();
        autoSubmitQuiz(); // Automatically submit the quiz when time is up
      }
    });
  }

  // Convert the remaining time into a mm:ss format
  String formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      appBar: AppBar(
        backgroundColor: MyColors.mint,
        title: const Center(
          child: Text(
            "MCQ Quiz",
            textAlign: TextAlign.center,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          // Timer in the AppBar's trailing position
          Padding(
            padding: EdgeInsets.only(right: 16.sp),
            child: Center(
              child: Text(
                formatTime(remainingTime), // Display formatted time
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: MyColors.seashall,
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<QuestionMCQ>>(
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
            List<QuestionMCQ> quiz = [];
            snapshot.data!.forEach((element) {
              if (element.difficulty == widget.difficulty) {
                quiz.add(element);
              }
            });

            return ListView.builder(
                padding:
                    EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // overflowSpacing: 12,
                          // overflowAlignment: OverflowBarAlignment.start,
                          // buttonPadding: EdgeInsets.symmetric(
                          //     horizontal: 20.sp, vertical: 10.sp),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (isAdd[index] == false) {
                                      setState(() {
                                        isAdd[index] = true;

                                        if (quiz[index].answer ==
                                            quiz[index].opt[0]) {
                                          isCorrect[index] = 1;
                                          toMassage(msg: "correct");
                                          correct++;
                                        } else {
                                          if (quiz[index].answer ==
                                              quiz[index].opt[0]) {
                                            isCorrect[index] = 1;
                                          } else if (quiz[index].answer ==
                                              quiz[index].opt[1]) {
                                            isCorrect[index] = 2;
                                          } else if (quiz[index].answer ==
                                              quiz[index].opt[2]) {
                                            isCorrect[index] = 3;
                                          } else {
                                            isCorrect[index] = 4;
                                          }

                                          toMassage(msg: "incorrect");
                                        }
                                        PreviousQuestions.questions.add(
                                            PreviousQuestion(
                                                id: index,
                                                question: quiz[index].question,
                                                correct: isCorrect[index] == 0
                                                    ? true
                                                    : false));
                                      });
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: (isAdd[index] == false)
                                        ? WidgetStateProperty.all(MyColors.mint)
                                        : ((isCorrect[index] == 1)
                                            ? WidgetStateProperty.all(
                                                Colors.green)
                                            : WidgetStateProperty.all(
                                                Colors.red)),
                                    elevation: WidgetStateProperty.all(10),
                                    fixedSize: WidgetStateProperty.all(
                                        Size(150.w, 50.h)),
                                    side: WidgetStateProperty.all(
                                        const BorderSide(color: Colors.white)),
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    quiz[index].opt[0],
                                    style: TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (isAdd[index] == false) {
                                      setState(() {
                                        isAdd[index] = true;

                                        if (quiz[index].answer ==
                                            quiz[index].opt[1]) {
                                          isCorrect[index] = 2;
                                          toMassage(msg: "correct");
                                          correct++;
                                        } else {
                                          if (quiz[index].answer ==
                                              quiz[index].opt[0]) {
                                            isCorrect[index] = 1;
                                          } else if (quiz[index].answer ==
                                              quiz[index].opt[1]) {
                                            isCorrect[index] = 2;
                                          } else if (quiz[index].answer ==
                                              quiz[index].opt[2]) {
                                            isCorrect[index] = 3;
                                          } else {
                                            isCorrect[index] = 4;
                                          }

                                          toMassage(msg: "incorrect");
                                        }
                                        PreviousQuestions.questions.add(
                                            PreviousQuestion(
                                                id: index,
                                                question: quiz[index].question,
                                                correct: isCorrect[index] == 0
                                                    ? true
                                                    : false));
                                      });
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: (isAdd[index] == false)
                                        ? WidgetStateProperty.all(MyColors.mint)
                                        : ((isCorrect[index] == 2)
                                            ? WidgetStateProperty.all(
                                                Colors.green)
                                            : WidgetStateProperty.all(
                                                Colors.red)),
                                    elevation: WidgetStateProperty.all(10),
                                    fixedSize: WidgetStateProperty.all(
                                        Size(150.w, 50.h)),
                                    side: WidgetStateProperty.all(
                                        const BorderSide(color: Colors.white)),
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    quiz[index].opt[1],
                                    style: TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      if (isAdd[index] == false) {
                                        setState(() {
                                          isAdd[index] = true;

                                          if (quiz[index].answer ==
                                              quiz[index].opt[2]) {
                                            isCorrect[index] = 3;
                                            toMassage(msg: "correct");
                                            correct++;
                                          } else {
                                            if (quiz[index].answer ==
                                                quiz[index].opt[0]) {
                                              isCorrect[index] = 1;
                                            } else if (quiz[index].answer ==
                                                quiz[index].opt[1]) {
                                              isCorrect[index] = 2;
                                            } else if (quiz[index].answer ==
                                                quiz[index].opt[2]) {
                                              isCorrect[index] = 3;
                                            } else {
                                              isCorrect[index] = 4;
                                            }

                                            toMassage(msg: "incorrect");
                                          }
                                          PreviousQuestions.questions.add(
                                              PreviousQuestion(
                                                  id: index,
                                                  question:
                                                      quiz[index].question,
                                                  correct: isCorrect[index] == 0
                                                      ? true
                                                      : false));
                                        });
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: (isAdd[index] == false)
                                          ? WidgetStateProperty.all(
                                              MyColors.mint)
                                          : ((isCorrect[index] == 3)
                                              ? WidgetStateProperty.all(
                                                  Colors.green)
                                              : WidgetStateProperty.all(
                                                  Colors.red)),
                                      elevation: WidgetStateProperty.all(10),
                                      fixedSize: WidgetStateProperty.all(
                                          Size(150.w, 50.h)),
                                      side: WidgetStateProperty.all(
                                          const BorderSide(
                                              color: Colors.white)),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      quiz[index].opt[2],
                                      style: TextStyle(
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis),
                                    )),
                                ElevatedButton(
                                  onPressed: () {
                                    if (isAdd[index] == false) {
                                      setState(() {
                                        isAdd[index] = true;

                                        if (quiz[index].answer ==
                                            quiz[index].opt[3]) {
                                          isCorrect[index] = 4;
                                          toMassage(msg: "correct");
                                          correct++;
                                        } else {
                                          if (quiz[index].answer ==
                                              quiz[index].opt[0]) {
                                            isCorrect[index] = 1;
                                          } else if (quiz[index].answer ==
                                              quiz[index].opt[1]) {
                                            isCorrect[index] = 2;
                                          } else if (quiz[index].answer ==
                                              quiz[index].opt[2]) {
                                            isCorrect[index] = 3;
                                          } else {
                                            isCorrect[index] = 4;
                                          }

                                          toMassage(msg: "incorrect");
                                        }
                                        PreviousQuestions.questions.add(
                                            PreviousQuestion(
                                                id: index,
                                                question: quiz[index].question,
                                                correct: isCorrect[index] == 0
                                                    ? true
                                                    : false));
                                      });
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: (isAdd[index] == false)
                                        ? WidgetStateProperty.all(MyColors.mint)
                                        : ((isCorrect[index] == 4)
                                            ? WidgetStateProperty.all(
                                                Colors.green)
                                            : WidgetStateProperty.all(
                                                Colors.red)),
                                    elevation: WidgetStateProperty.all(10),
                                    fixedSize: WidgetStateProperty.all(
                                        Size(150.w, 50.h)),
                                    side: WidgetStateProperty.all(
                                        const BorderSide(color: Colors.white)),
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    quiz[index].opt[3],
                                    style: TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).py(5.sp);
                });
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
            onPressed: () async {
              if (isAdd.contains(false)) {
                toMassage(msg: "Please answer all questions!");
                return;
              }

              bool confirm = await showSubmissionConfirmationDialog(context);

              // If confirmed, proceed with submission
              if (confirm) {
                await scoreUpdate(context);
                int currentPerformance =
                    ((correct * 10) + CurrentUser.currentUser.performance) ~/ 2;
                CurrentUser.currentUser.performanceUpdate(
                    context: context,
                    currentEmail: CurrentUser.currentUser.email,
                    currentPerformance: currentPerformance);

                Scores.updateScores(
                  context: context,
                  score: Scores.scores,
                  email: CurrentUser.currentUser.email,
                );

                PreviousQuestions.addToCollection(
                    context: context,
                    question: PreviousQuestions.questions,
                    email: CurrentUser.currentUser.email);

                Navigator.pushReplacementNamed(
                  context,
                  MyRoutes.homeRoute,
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(MyColors.mint),
              elevation: WidgetStateProperty.all(10),
              side: WidgetStateProperty.all(
                  const BorderSide(color: MyColors.seashall, width: 2)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    15.sp,
                  ),
                ),
              ),
            ),
            child: "submit".text.xl2.make(),
          ).p(12.sp),
        ),
      ),
    );
  }

  Future<void> autoSubmitQuiz() async {
    await scoreUpdate(context);
    int currentPerformance =
        ((correct * 10) + CurrentUser.currentUser.performance) ~/ 2;
    CurrentUser.currentUser.performanceUpdate(
        context: context,
        currentEmail: CurrentUser.currentUser.email,
        currentPerformance: currentPerformance);

    Scores.updateScores(
        context: context,
        score: Scores.scores,
        email: CurrentUser.currentUser.email);

    PreviousQuestions.addToCollection(
        context: context,
        question: PreviousQuestions.questions,
        email: CurrentUser.currentUser.email);

    Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
  }

  Future<bool> showSubmissionConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Submit Quiz'),
            content: const Text('Are you sure you want to submit the quiz?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Return false if canceled
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Return true if confirmed
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ) ??
        false; // If dialog is dismissed, return false by default
  }

  void scoreListAdd(BuildContext context) {
    // Add the new score to the list
    Scores.scores.add(Score(
      correct: correct,
      scoreInPercent: correct * 10,
      date: DateFormat('dd / MM / yyyy').format(DateTime.now()).toString(),
    ));

    // Ensure we only keep the last 10 scores
    if (Scores.scores.length > 10) {
      Scores.scores = Scores.scores.sublist(Scores.scores.length - 10);
    }

    // Update the scores in Firestore
    Scores.addScores(
      context: context,
      score: Scores.scores,
      email: CurrentUser.currentUser.email,
    );
  }

  Future<void> scoreFetch() async {
    print("score: ${CurrentUser.currentUser.email}");
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection("users")
        .doc(CurrentUser.currentUser.email)
        .collection("previousScores")
        .doc("scores");

    try {
      DocumentSnapshot data = await userDocRef.get();

      if (data.exists) {
        // Document with scores exists, fetch scores
        List temp = data['scores'];
        print(temp.length);

        for (int i = 0; i < temp.length; i++) {
          Scores.scores.add(Score(
            correct: data['scores'][i]['correct'],
            scoreInPercent: data['scores'][i]['scoreInPercent'],
            date: data['scores'][i]['date'],
          ));
        }

        print(Scores.scores.length);
      } else {
        // Document does not exist, create a new one with an empty list
        await userDocRef.set({'scores': []});
      }
    } catch (e) {
      print("Error fetching scores: $e");
    }
  }

  Future<void> scoreUpdate(BuildContext context) async {
    // Clear the current scores
    Scores.scores.clear();

    // Fetch existing scores
    await scoreFetch();

    // Add the new score and ensure the list has only the last 10 scores
    scoreListAdd(context);
  }
}

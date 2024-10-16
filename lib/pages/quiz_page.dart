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

class QuizPage extends StatefulWidget {
  final String difficulty;

  const QuizPage({Key? key, required this.difficulty}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<List<QuestionTF>> quizFuture;
  List<bool> _userAnswer = List.generate(10, (i) => false);
  List<bool> _correctAnswer = List.generate(10, (i) => false);

  int correct = 0;
  Timer? timer; // Declare a timer
  int remainingTime = 600; // 10 minutes in seconds
  @override
  void initState() {
    super.initState();
    quizFuture = Questions().getTFQuestions();
    startTimer(); // Start the timer when the quiz page is initialized
  }

  late List<bool> isAdd = List.generate(10, (i) => false);
  late List<int> isCorrect = List.generate(10, (i) => -1);
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
            "Quiz Genius",
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
      body: FutureBuilder<List<QuestionTF>>(
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
            List<QuestionTF> quiz = [];
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
                        OverflowBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                  _userAnswer[index] = true;
                                if (isAdd[index] == false) {
                                  setState(() {
                                    isAdd[index] = true;

                                    if (quiz[index].answer == true) {
                                      _correctAnswer[index] = true;
                                      isCorrect[index] = 0;
                                      toMassage(msg: "correct");
                                      correct++;
                                    } else {
                                      isCorrect[index] = 1;
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
                                    : ((isCorrect[index] == 0)
                                        ? WidgetStateProperty.all(
                                            Colors.green)
                                        : WidgetStateProperty.all(
                                            Colors.red)),
                                elevation: WidgetStateProperty.all(10),
                                fixedSize: WidgetStateProperty.all(
                                    Size(120.w, 40.h)),
                                side: WidgetStateProperty.all(
                                    const BorderSide(color: Colors.white)),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                ),
                              ),
                              child: "True".text.xl.make(),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (isAdd[index] == false) {
                                  setState(() {
                                    isAdd[index] = true;
                                    if (quiz[index].answer == false) {
                                      isCorrect[index] = 1;
                                      toMassage(msg: "correct");
                                      correct++;
                                    } else {
                                      _correctAnswer[index] = true;
                                      isCorrect[index] = 0;
                                      toMassage(msg: "incorrect");
                                    }
                                    PreviousQuestions.questions.add(
                                        PreviousQuestion(
                                            id: index,
                                            question: quiz[index].question,
                                            correct: isCorrect[index] == 1
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
                                    Size(120.w, 40.h)),
                                side: WidgetStateProperty.all(
                                    const BorderSide(color: Colors.white)),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                ),
                              ),
                              child: "False".text.xl.make(),
                            ),
                          ],
                        ),
                        isAdd[index] == false
                            ? SizedBox.shrink()
                            : _correctAnswer[index] ==
                                    _userAnswer[index] //answered correctly
                                ? Container(
                                    alignment:
                                        Alignment.centerLeft, // Align left
                                    padding:
                                        EdgeInsets.all(8.sp), // Add padding
                                    child: Text(
                                      'Correct Answer!\nYou Selected ' +
                                          (_userAnswer[index] == true
                                              ? 'True'
                                              : 'False'),
                                      style: TextStyle(
                                        color: Colors.green[
                                            800], // Change to a brighter green
                                        fontSize: 18.sp, // Increase font size
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign
                                          .left, // Ensure text is aligned left
                                    ),
                                  )
                                : Container(
                                    alignment:
                                        Alignment.centerLeft, // Align left
                                    padding:
                                        EdgeInsets.all(8.sp), // Add padding
                                    child: Text(
                                      'Incorrect Answer\nYou Selected ' +
                                          (_userAnswer[index] == true
                                              ? 'True'
                                              : 'False'),
                                      style: TextStyle(
                                        color: Colors
                                            .red[400], // Change to a deeper red
                                        fontSize: 18.sp, // Increase font size
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign
                                          .left, // Ensure text is aligned left
                                    ),
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
              backgroundColor: MaterialStateProperty.all(MyColors.mint),
              elevation: MaterialStateProperty.all(10),
              side: MaterialStateProperty.all(
                  const BorderSide(color: MyColors.seashall, width: 2)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
              ),
            ),
            child: const Center(
              child: Text(
                "Submit",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
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

  Future<void> scoreUpdate(BuildContext context) async {
    // Add the new score to the list of scores.
    Scores.scores.add(
      Score(
        correct: correct, // Number of correct answers
        scoreInPercent:
            (correct * 10), // Calculate percentage or whatever logic you have
        date: DateFormat('yyyy-MM-dd')
            .format(DateTime.now()), // Add the current date
      ),
    );
  }
}

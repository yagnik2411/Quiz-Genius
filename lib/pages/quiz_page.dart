import 'dart:async'; // For Timer

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/models/previous_questions.dart';
import 'package:quiz_genius/models/questions.dart';
import 'package:quiz_genius/models/scores.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:quiz_genius/utils/toast.dart';
import 'package:velocity_x/velocity_x.dart';

class QuizPage extends StatefulWidget {
  final String difficulty;

  const QuizPage({Key? key, required this.difficulty}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<List<QuestionTF>> quizFuture;

  int correct = 0;
  Timer? timer; // Declare a timer
  int remainingTime = 600; // 10 minutes in seconds
  Future<List<QuestionTF>> fetchQuiz() async {
    Set<QuestionTF> quizSet =
        {}; // Use a Set to automatically handle duplicates

    // Limit iterations to avoid infinite loops
    const int maxAttempts = 10;
    int attempts = 0;

    while (quizSet.length < 10 && attempts < maxAttempts) {
      List<QuestionTF>? fetchedQuiz =
          await Questions().getTFQuestions(widget.difficulty);

      // Ensure fetchedQuiz is not null
      if (fetchedQuiz.isNotEmpty) {
        // Filter based on difficulty and add to Set
        for (var element in fetchedQuiz) {
          if (element.difficulty == widget.difficulty) {
            quizSet.add(element); // Set will handle duplicates
          }
        }
      }
      attempts++;
    }

    // Convert Set back to List and ensure at least 10 questions
    return quizSet.isEmpty
        ? []
        : quizSet
            .toList()
            .sublist(0, quizSet.length < 10 ? quizSet.length : 10);
  }

  @override
  void initState() {
    super.initState();
    quizFuture = fetchQuiz();

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
        future: quizFuture, // Future holding the quiz data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Handle the case when no data is available
            return const Center(
              child: Text("No questions available."),
            );
          } else {
            List<QuestionTF> quiz = snapshot.data ?? [];
            print(quiz.length);
            return ListView.builder(
                padding:
                    EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
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
                            // Parse and display the question text
                            parse(quiz[index].question).body?.text ??
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
                            // "True" button to select True as an answer
                            ElevatedButton(
                              onPressed: () {
                                if (isAdd[index] == false) {
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
                              // Update button style based on answer correctness
                              style: ButtonStyle(
                                backgroundColor: (isAdd[index] == false)
                                    ? WidgetStateProperty.all(MyColors.mint)
                                    : ((isCorrect[index] == 0)
                                        ? WidgetStateProperty.all(Colors.green)
                                        : WidgetStateProperty.all(Colors.red)),
                                elevation: WidgetStateProperty.all(10),
                                fixedSize:
                                    WidgetStateProperty.all(Size(120.w, 40.h)),
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
                            // "False" button to select False as an answer
                            ElevatedButton(
                              onPressed: () {
                                if (isAdd[index] == false) {
                                  setState(() {
                                    isAdd[index] =
                                        true; // Mark question as answered
                                    if (quiz[index].answer == false) {
                                      isCorrect[index] =
                                          1; // Mark as correct if the answer is false
                                      toMassage(msg: "correct");
                                      correct++; // Increment correct answer count
                                    } else {
                                      isCorrect[index] = 0;
                                      toMassage(
                                          msg:
                                              "incorrect"); // Mark as incorrect
                                    }
                                    // Add question to the previous questions list
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
                                        ? WidgetStateProperty.all(Colors.green)
                                        : WidgetStateProperty.all(Colors.red)),
                                elevation: WidgetStateProperty.all(10),
                                fixedSize:
                                    WidgetStateProperty.all(Size(120.w, 40.h)),
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
                      ],
                    ),
                  ).py(5.sp);
                },
                itemCount: quiz.length);
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

  void scoreListAdd(BuildContext context) {
    // Add the new score to the list
    Scores.scores.add(
      Score(
        correct: correct, // Number of correct answers
        scoreInPercent:
            (correct * 10), // Calculate percentage or whatever logic you have
        date: DateFormat('yyyy-MM-dd')
            .format(DateTime.now()), // Add the current date
      ),
    );

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
    // Add the new score to the list of scores.

    // Scores.scores.add(
    //   Score(
    //     correct: correct, // Number of correct answers
    //     scoreInPercent:
    //         (correct * 10), // Calculate percentage or whatever logic you have
    //     date: DateFormat('yyyy-MM-dd')
    //         .format(DateTime.now()), // Add the current date
    //   ),
    // );
    Scores.scores.clear();

    // Fetch existing scores
    await scoreFetch();

    // Add the new score and ensure the list has only the last 10 scores
    scoreListAdd(context);
  }
}

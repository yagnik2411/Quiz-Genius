import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz_genius/main.dart';
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
  // List<PreviousQuestions> previousQuestions = [];
  @override
  void initState() {
    super.initState();
    quizFuture = Questions().getQuestions();
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
                padding: EdgeInsets.symmetric(
                    vertical: correctSize(8), horizontal: correctSize(16)),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(correctSize(8)),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.darkCyan, width: 3),
                      borderRadius: BorderRadius.circular(correctSize(15)),
                      color: MyColors.malachite.withOpacity(0.8),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            quiz[index + 10].question,
                            style: TextStyle(
                              color: MyColors.seashall,
                              fontSize: correctSize(15),
                              fontWeight: FontWeight.values[5],
                            ),
                            textWidthBasis: TextWidthBasis.parent,
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          buttonPadding: EdgeInsets.symmetric(
                              horizontal: correctSize(20),
                              vertical: correctSize(10)),
                          children: [
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
                              style: ButtonStyle(
                                backgroundColor: (isAdd[index] == false)
                                    ? MaterialStateProperty.all(MyColors.mint)
                                    : ((isCorrect[index] == 0)
                                        ? MaterialStateProperty.all(
                                            Colors.green)
                                        : MaterialStateProperty.all(
                                            Colors.red)),
                                elevation: MaterialStateProperty.all(10),
                                fixedSize: MaterialStateProperty.all(
                                    Size(correctSize(120), correctSize(40))),
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.white)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(correctSize(15)),
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
                                    ? MaterialStateProperty.all(MyColors.mint)
                                    : ((isCorrect[index] == 1)
                                        ? MaterialStateProperty.all(
                                            Colors.green)
                                        : MaterialStateProperty.all(
                                            Colors.red)),
                                elevation: MaterialStateProperty.all(10),
                                fixedSize: MaterialStateProperty.all(
                                    Size(correctSize(120), correctSize(40))),
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.white)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(correctSize(15)),
                                  ),
                                ),
                              ),
                              child: "False".text.xl.make(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).py(correctSize(5));
                });
          }
        },
      ),
      bottomNavigationBar: Container(
        height: correctSize(80),
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
          margin: EdgeInsets.symmetric(
              horizontal: correctSize(15), vertical: correctSize(5)),
          child: ElevatedButton(
            onPressed: () {
              Scores.scores.clear();
              scoreFetch();
              print(Scores.scores.length);
              int currentPerformance =
                  ((correct * 10) + CurretUser.currentUser.performance) ~/ 2;
              CurretUser.currentUser.performanceUpadate(
                  context: context,
                  currentEmail: CurretUser.currentUser.email,
                  currentPerformance: currentPerformance);
              Scores.scores.add(Score(
                  correct: correct,
                  scoreInPercent: correct * 10,
                  date: DateFormat(' dd / MM / yyyy ')
                      .format(DateTime.now())
                      .toString()));
              Scores.updateScores(
                  context: context,
                  score: Scores.scores,
                  email: CurretUser.currentUser.email);
              print(Scores.scores.length);
              PreviousQuestions.addToCollection(
                  context: context,
                  question: PreviousQuestions.questions,
                  email: CurretUser.currentUser.email);
              Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyColors.mint),
              elevation: MaterialStateProperty.all(correctSize(10)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: MyColors.seashall, width: 2)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    correctSize(15),
                  ),
                ),
              ),
            ),
            child: "submit".text.xl2.make(),
          ).p(correctSize(12)),
        ),
      ),
    );
  }

  void scoreListAdd(BuildContext context) {
    Scores.scores.add(Score(
        correct: correct,
        scoreInPercent: correct * 10,
        date:
            DateFormat(' dd / MM / yyyy ').format(DateTime.now()).toString()));
    Scores.addScores(
        context: context,
        score: Scores.scores,
        email: CurretUser.currentUser.email);
  }

  scoreFetch() async {
    print("score:${CurretUser.currentUser.email}");
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection("users")
        .doc(CurretUser.currentUser.email)
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
      
    }
  }

  ScoreUpadate() {
    Scores.scores.clear();
    scoreFetch();
    scoreListAdd(context);
  }
}

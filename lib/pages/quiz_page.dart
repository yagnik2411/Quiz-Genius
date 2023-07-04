import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_genius/models/previous_questions.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:quiz_genius/models/questions.dart';
import 'package:quiz_genius/utils/colors.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<List<Question>> quizFuture;
  List<bool> isAdd = List.generate(50, (i) => false);
  List<int> isCorrect = List.generate(50, (i) => -1);
  List<PreviousQuestions> previousQuestions = [];
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
        title: const Text("Quiz Genius").centered(),
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemCount: quiz.length,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.darkCyan, width: 3),
                  borderRadius: BorderRadius.circular(15),
                  color: MyColors.malachite.withOpacity(0.8),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        quiz[index].question,
                        style: TextStyle(
                          color: MyColors.seashall,
                          fontSize: 15,
                          fontWeight: FontWeight.values[5],
                        ),
                        textWidthBasis: TextWidthBasis.parent,
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      buttonPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (isAdd[index] == false) {
                              setState(() {
                                isAdd[index] = true;
                                // ignore: unrelated_type_equality_checks
                                if (quiz[index].answer == true) {
                                  isCorrect[index] = 0;
                                } else {
                                  isCorrect[index] = 1;
                                }
                              });
                            }
                            print(quiz[index].answer);
                            print(isCorrect[index]);
                          },
                          style: ButtonStyle(
                            backgroundColor: (isAdd[index] == false)
                                ? MaterialStateProperty.all(MyColors.mint)
                                : ((isCorrect[index] == 0 ) 
                                    ? MaterialStateProperty.all(Colors.green)
                                    : MaterialStateProperty.all(Colors.red)),
                            elevation: MaterialStateProperty.all(10),
                            fixedSize:
                                MaterialStateProperty.all(const Size(120, 40)),
                            side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.white)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
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
                                } else {
                                  isCorrect[index] = 0;
                                }
                              });
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: (isAdd[index] == false)
                                ? MaterialStateProperty.all(MyColors.mint)
                                : ((isCorrect[index] == 1 )
                                    ? MaterialStateProperty.all(Colors.green)
                                    : MaterialStateProperty.all(Colors.red)),
                            elevation: MaterialStateProperty.all(10),
                            fixedSize:
                                MaterialStateProperty.all(const Size(120, 40)),
                            side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.white)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          child: "False".text.xl.make(),
                        ),
                      ],
                    ),
                  ],
                ),
              ).py(5),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 80,
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
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: ElevatedButton(
            onPressed: () {
              
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyColors.mint),
              elevation: MaterialStateProperty.all(10),
              side: MaterialStateProperty.all(
                  const BorderSide(color: MyColors.seashall, width: 2)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
              ),
            ),
            child: "submit".text.xl2.make(),
          ).p12(),
        ),
      ),
    );
  }
}

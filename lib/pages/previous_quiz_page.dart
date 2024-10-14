import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:quiz_genius/models/previous_questions.dart';
import 'package:quiz_genius/utils/colors.dart';

class PreviousQuiz extends StatefulWidget {
  const PreviousQuiz({Key? key}) : super(key: key);

  @override
  State<PreviousQuiz> createState() => _PreviousQuizState();
}

String checkAnswer(bool answer) {
  return answer ? "Correct" : "Incorrect";
}

class _PreviousQuizState extends State<PreviousQuiz> {
  @override
  void initState() {
    super.initState();
    // Clear any previous questions in the list to avoid duplicates
    PreviousQuestions.questions.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: questionFetch(),
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
              child: (PreviousQuestions.questions.isNotEmpty)
                  ? ListView.builder(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
                      itemCount: PreviousQuestions.questions.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColors.darkCyan, width: 3.w),
                            borderRadius: BorderRadius.circular(15.sp),
                            color: MyColors.malachite.withOpacity(0.8),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  PreviousQuestions.questions[index].question,
                                  style: TextStyle(
                                    color: MyColors.seashall,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.values[5],
                                  ),
                                  textWidthBasis: TextWidthBasis.parent,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.sp, vertical: 10.sp),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(15.sp),
                                  color: MyColors.mint,
                                ),
                                child: Text(
                                  "${checkAnswer(PreviousQuestions.questions[index].correct)}",
                                  style: TextStyle(
                                    color: MyColors.seashall,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textWidthBasis: TextWidthBasis.parent,
                                ),
                              ),
                            ],
                          ),
                        ).py(5.sp);
                      },
                    )
                  : Center(
                      child: Text("No Previous Quizzes Found")
                          .text
                          .xl3
                          .color(MyColors.malachite)
                          .bold
                          .make()
                          .p(16.sp),
                    ),
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
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> questionFetch() async {
    try {
      DocumentSnapshot data = await FirebaseFirestore.instance
          .collection("users")
          .doc(CurrentUser.currentUser.email)
          .collection("previousQuestions")
          .doc("Questions")
          .get();

      if (data.exists && data['Questions'] != null) {
        List<dynamic> questionsData = data['Questions'];
        for (var question in questionsData) {
          PreviousQuestions.questions.add(PreviousQuestion.fromMap(question));
        }
      } else {
        print("No previous questions found in Firestore.");
      }
    } catch (e) {
      print("Error fetching previous questions: $e");
    }
  }
}

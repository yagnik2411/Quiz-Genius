import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_genius/models/previous_questions.dart';
import 'package:quiz_genius/models/previous_questions.dart';

import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class PreviousQuiz extends StatefulWidget {
  const PreviousQuiz({Key? key}) : super(key: key);

  @override
  State<PreviousQuiz> createState() => _PreviousQuizState();
}


String checkAnswer(bool Answer) {
  if (Answer) { 
    return "Correct";
  } else {
    return "Incorrect";
  }
}

class _PreviousQuizState extends State<PreviousQuiz> {
  @override
  Widget build(BuildContext context) {
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
       body:ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: PreviousQuestions.questions.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.darkCyan, width: 3),
            borderRadius: BorderRadius.circular(15),
            color: MyColors.malachite.withOpacity(0.8),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  PreviousQuestions.questions[index].question,
                  style: TextStyle(
                    color: MyColors.seashall,
                    fontSize: 17,
                    fontWeight: FontWeight.values[5],
                  ),
                  textWidthBasis: TextWidthBasis.parent,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                // height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(15),
                  color: MyColors.mint,
                ),
                child: Text(
                  "${checkAnswer(PreviousQuestions.questions[index].correct)}",
                  style: TextStyle(
                    color: MyColors.seashall,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  textWidthBasis: TextWidthBasis.parent,
                )
                ),
              
            
            ],
          ),
        ),
      ),
    );
  }
}

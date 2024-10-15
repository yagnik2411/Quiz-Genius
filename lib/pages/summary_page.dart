import 'package:flutter/material.dart';
import 'package:quiz_genius/models/previous_questions.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:quiz_genius/utils/my_route.dart';

class SummaryPage extends StatelessWidget {
  final List<PreviousQuestion> previousQuestions;

  const SummaryPage({required this.previousQuestions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the total number of correct answers
    int correctAnswers = previousQuestions.where((q) => q.correct).length;

    // Calculate the percentage score
    double percentage = (correctAnswers / previousQuestions.length) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Summary"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Custom action for back button
            PreviousQuestions.questions = [];
            Navigator.pushNamed(
                context, MyRoutes.homeRoute); // Example: Go to home
          },
        ),
        backgroundColor: MyColors.mint,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display total correct answers out of total questions
            Text(
              "Correct Answers: $correctAnswers / ${previousQuestions.length}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Display the percentage score
            RichText(
                text: TextSpan(
              text: "Percentage: ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: percentage.toStringAsFixed(2),
                  style: TextStyle(
                    color: percentage <= 50 ? Colors.red : MyColors.mint,
                  ),
                ),
                TextSpan(text: "%"),
              ],
            )),

            const SizedBox(height: 20),

            // Divider for separation
            const Divider(thickness: 2),

            // Detailed breakdown of each question
            Expanded(
              child: ListView.builder(
                itemCount: previousQuestions.length,
                itemBuilder: (context, index) {
                  final question = previousQuestions[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: index % 2 == 0 ? MyColors.mint : MyColors.lightCyan,
                    child: ListTile(
                      title: Text(question.question),
                      trailing: Icon(
                        question.correct ? Icons.check_circle : Icons.cancel,
                        color: question.correct ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

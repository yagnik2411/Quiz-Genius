import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:quiz_genius/models/questions.dart';


class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Genius"),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: Questions.questions.length,
          
          itemBuilder:(context, index) => Card()
          ,)
      ),
    );
  }
}
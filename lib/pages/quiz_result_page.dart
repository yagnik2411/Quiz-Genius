import 'package:flutter/material.dart';

class QuizResultPage extends StatefulWidget {
  const QuizResultPage({super.key});
  @override
  _QuizResultPageState createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Results!'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Quiz Result Page'),
      ),
    );
  }
}

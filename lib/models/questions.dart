import 'dart:convert';

import 'package:http/http.dart' as http;

class Questions {
  List<Question_T_F> questions = [];

  Future<List<Question_T_F>> getTFQuestions() async {
    List<Question_T_F> questions = [];
    final String url = "https://opentdb.com/api.php?amount=50&type=boolean";
    final response = await http.get(Uri.parse(url));
    final String data = response.body;
    final decodeData = jsonDecode(data);
    var question = decodeData["results"];
    for (int i = 0; i < question.length; i++) {
      questions.add(
        Question_T_F(
          i,
          question[i]["question"],
          question[i]["correct_answer"] == "True" ? true : false,
        ),
      );
    }
    return questions;
  }

  Future<List<Question_MCQ>> getMCQQuestions() async {
    List<Question_MCQ> questions = [];
    final String url =
        "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple";
    final response = await http.get(Uri.parse(url));
    final String data = response.body;
    final decodeData = jsonDecode(data);
    var question = decodeData["results"];
    print(question);
    for (int i = 0; i < question.length; i++) {
      // List<dynamic> answer =
      //     question[i]['incorrect_answers'].map((x) => x).toList();
      //
      // List answers = question[i]['correct_answer'] + answer;
      List<String> answers = [
        question[i]["incorrect_answers"][0],
        question[i]["incorrect_answers"][1],
        question[i]["incorrect_answers"][2],
        question[i]["correct_answer"],
      ];
      answers.shuffle();
      questions.add(
        Question_MCQ(
          i,
          question[i]["question"],
          question[i]["correct_answer"],
          answers,
        ),
      );
    }
    return questions;
  }
}

class Question_MCQ {
  int id;
  String question;
  String answer;
  List<String> opt;

  Question_MCQ(
    this.id,
    this.question,
    this.answer,
    this.opt,
  );
}

class Question_T_F {
  int id;
  String question;
  bool answer;

  Question_T_F(this.id, this.question, this.answer);
}

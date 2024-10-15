import 'dart:convert';

import 'package:http/http.dart' as http;

class Questions {
  List<QuestionTF> questions = [];

  Future<List<QuestionTF>> getTFQuestions() async {
    List<QuestionTF> questions = [];

    final String url = "https://opentdb.com/api.php?amount=50&type=boolean";
    final response = await http.get(Uri.parse(url));
    final String data = response.body;
    final decodeData = jsonDecode(data);
    var question = decodeData["results"];
    for (int i = 0; i < question.length; i++) {
      questions.add(
        QuestionTF(
          i,
          question[i]["question"],
          question[i]["correct_answer"] == "True" ? true : false,
        ),
      );
    }

    return questions;
  }

  Future<List<QuestionMCQ>> getMCQQuestions() async {
    List<QuestionMCQ> questions = [];
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
        QuestionMCQ(
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

class QuestionMCQ {
  int id;
  String question;
  String answer;
  List<String> opt;

  QuestionMCQ(
    this.id,
    this.question,
    this.answer,
    this.opt,
  );
}

class QuestionTF {
  int id;
  String question;
  bool answer;

  QuestionTF(this.id, this.question, this.answer);
}

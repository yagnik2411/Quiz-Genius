import 'dart:convert';

import 'package:http/http.dart' as http;

class Questions {
  List<Question> questions = [];

  Future<List<Question>> getQuestions() async {
    List<Question> questions = [];
    final String url = "https://opentdb.com/api.php?amount=50&type=boolean";
    final response = await http.get(Uri.parse(url));
    final String data = response.body;
    final decodeData = jsonDecode(data);
    var question = decodeData["results"];
    for (int i = 0; i < question.length; i++) {
      questions.add(
        Question(
          i,
          question[i]["question"],
          question[i]["correct_answer"] == "True" ? true : false,
        ),
      );
    }
    return questions;
  }
}

class Question {
  int id;
  String question;
  bool answer;

  Question(this.id, this.question, this.answer);
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class Questions {
  List<QuestionTF> questions = [];

  Future<List<QuestionTF>> getTFQuestions(String difficulty) async {
    List<QuestionTF> questions = [];
    print(difficulty);
    // Updated URL to include difficulty as a parameter
    final String url =
        "https://opentdb.com/api.php?amount=50&type=boolean&difficulty=$difficulty";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final String data = response.body;
      final decodeData = jsonDecode(data);
      var question = decodeData["results"];

      for (int i = 0; i < question.length; i++) {
        questions.add(
          QuestionTF(
            i,
            question[i]["question"],
            question[i]["difficulty"],
            question[i]["correct_answer"] == "True" ? true : false,
          ),
        );
      }
    } else {
      throw Exception("Failed to load questions");
    }

    return questions;
  }

  Future<List<QuestionMCQ>> getMCQQuestions(String difficulty) async {
    List<QuestionMCQ> questions = [];
    // Updated URL to include difficulty as a parameter
    final String url = "https://opentdb.com/api.php?amount=50&type=multiple&difficulty=$difficulty";
    
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final String data = response.body;
      final decodeData = jsonDecode(data);
      var question = decodeData["results"];

      for (int i = 0; i < question.length; i++) {
        // Combine incorrect answers and correct answer into one list
        List<String> answers = [
          ...question[i]["incorrect_answers"].map<String>((answer) => answer),
          question[i]["correct_answer"],
        ];
        
        // Shuffle the answers to randomize their order
        answers.shuffle();

        // Add each question to the list
        questions.add(
          QuestionMCQ(
            i,
            question[i]["question"],
            question[i]["correct_answer"],
            question[i]["difficulty"],
            answers,
          ),
        );
      }
    } else {
      throw Exception("Failed to load questions");
    }

    return questions;
  }
}

class QuestionMCQ {
  int id;
  String question;
  String answer;
  String difficulty;
  List<String> opt;

  QuestionMCQ(
    this.id,
    this.question,
    this.answer,
    this.difficulty,
    this.opt,
  );
}

class QuestionTF {
  int id;
  String question;
  String difficulty;
  bool answer;

  QuestionTF(this.id, this.question, this.difficulty, this.answer);
}

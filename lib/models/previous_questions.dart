import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_genius/firebase/CRUD.dart';

class PreviousQuestions {
  static List<PreviousQuestion> questions = [];

  Future<void> addToCollection(
      {required BuildContext context,
      required List<PreviousQuestion> question,
      required String email}) async {
    List<Map<String, dynamic>> data = [];

    for (int i = 0; i < question.length; i++) {
      data.add(question[i].toMap(question[i]));
    }

    DocumentReference firestore = FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .collection("previousQuestions")
        .doc("Questions");

    await firestore
        .set(data)
        .whenComplete(() => print("data added"))
        .onError((error, stackTrace) => print(error));
  }
}

class PreviousQuestion {
  final int id;
  final String question;
  final bool correct;

  PreviousQuestion(
      {required this.id, required this.question, required this.correct});

  Map<String, dynamic> toMap(PreviousQuestion question) {
    return {
      "id": question.id,
      "question": question.question,
      "correct": question.correct,
    };
  }

  PreviousQuestion.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        question = map["question"],
        correct = map["correct"];
}

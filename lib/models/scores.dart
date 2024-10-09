// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Scores {
  static List<Score> scores = [];

  static void addScores(
      {required BuildContext context,
      required List<Score> score,
      required String email}) async {
    List<Map<String, dynamic>> data = [];
    for (int i = 0; i < score.length; i++) {
      data.add(score[i].toMap(score: score[i]));
    }
    Map<String, List<Map<String, dynamic>>> actualData = {"scores": data};

    DocumentReference firestore = FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .collection("previousScores")
        .doc("scores");
    await firestore
        .set(actualData)
        .whenComplete(() => print("data added"))
        .onError((error, stackTrace) => print(error));
  }

  static updateScores(
      {required BuildContext context,
      required List<Score> score,
      required String email}) async {
    DocumentReference firestore = FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .collection("previousScores")
        .doc("scores");
    await firestore
        .update({
          "scores": FieldValue.arrayUnion(
              score.map((e) => e.toMap(score: e)).toList())
        })
        .whenComplete(() => print("data added"))
        .onError((error, stackTrace) => print(error));
  }
}

class Score {
  final int correct;
  final int scoreInPercent;
  final String date;
  Score({
    required this.correct,
    required this.scoreInPercent,
    required this.date,
  });

  Map<String, dynamic> toMap({required Score score}) {
    Map<String, dynamic> MapScore = {
      "correct": score.correct,
      "scoreInPercent": score.scoreInPercent,
      "date": score.date
    };

    return MapScore;
  }

  Score.fromMap(Map<String, dynamic> map)
      : correct = map['correct'],
        scoreInPercent = map['scoreInPercent'],
        date = map['date'];
}

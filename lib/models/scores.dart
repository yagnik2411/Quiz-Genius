// ignore_for_file: public_member_api_docs, sort_constructors_first

class Scores {
  final List<score> scores = [score(correct: 7, scoreInPercent: 70)];
  // Scores({
  //   required this.scores,
  // });
}

class score {
  final int correct;
  final int scoreInPercent;
  score({
    required this.correct,
    required this.scoreInPercent,
  });
}

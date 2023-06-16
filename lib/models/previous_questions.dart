class Questions {
  static List<Question> questions = [
    Question(
        id: 1,
        question:
            "Horoscopes accurately predict future events 85% of the time.",
        correct: false),
  ];
}

class Question {
  final int id;
  final String question;
  final bool correct;

  Question({required this.id, required this.question, required this.correct});
}

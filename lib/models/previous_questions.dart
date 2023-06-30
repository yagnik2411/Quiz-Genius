class PreviousQuestions {
  static List<PreviousQuestion> questions = [
    PreviousQuestion(
        id: 1,
        question:
            "Horoscopes accurately predict future events 85% of the time.",
        correct: false),
  ];
}

class PreviousQuestion {
  final int id;
  final String question;
  final bool correct;

  PreviousQuestion({required this.id, required this.question, required this.correct});
}

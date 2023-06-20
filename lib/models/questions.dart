class Questions {
  static List<Question> questions = [
    Question(
        id: 1,
        question:
            "Horoscopes accurately predict future events 85% of the time.",
        answer: false),
  ];
}

class Question {
  final int id;
  final String question;
  final bool answer;

  Question({required this.id, required this.question, required this.answer});
}

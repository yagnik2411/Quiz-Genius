# Quiz Genius - A Flutter Quiz App

**Quiz Genius** is a quiz app built with Flutter and Dart, designed to provide an engaging quiz experience with various features that enhance user interaction and performance tracking.

## Features

- **User Profile:** Each user has a profile that saves their name and quiz performance for easy tracking.
- **Quiz History:** View previous quizzes and scores, allowing users to review past performance and questions.
- **Login & Data Saving:** User progress is saved through Firebase, ensuring continuity between sessions.
- **Take a Quiz:** Users can start a new quiz and test their knowledge on a variety of topics.

## Technical Implementation

- **User Login:** Authentication (login, sign-up, sign-in) is managed using Firebase Authentication.
- **Data Storage:** User data and quiz performance are stored securely using Cloud Firestore.
- **Questions Bank:** Quiz questions are fetched from a third-party API using JSON serialization to handle the data.
- **User-Friendly UI:** The app features a professional and intuitive UI, providing a seamless user experience.

## Example of API Structure (Question Bank)

The questions are pulled from an external API with the following structure:

```json
{
  "results": [
    {
      "type": "boolean",
      "difficulty": "medium",
      "category": "Geography",
      "question": "Is Tartu the capital of Estonia?",
      "correct_answer": "False",
      "incorrect_answers": [
        "True"
      ]
    }
  ]
}
```

## Contact

- [LinkedIn](https://www.linkedin.com/in/yagnikpanchal)
- [Email](mailto:panchalyagnik2411@gmail.com)

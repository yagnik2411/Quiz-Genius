# Quiz Genius - A Flutter Quiz App

**Quiz Genius** is a quiz app built with Flutter and Dart, designed to provide an engaging quiz experience with various features that enhance user interaction and performance tracking.

## UI Preview
<div align="center">
  <div align="center">
    <img src="https://github.com/yagnik2411/Quiz-Genius/blob/master/assets/images/Screenshot_1.png" alt="Screenshot 1" width="300"/>
    <img src="https://github.com/yagnik2411/Quiz-Genius/blob/master/assets/images/Screenshot_2.png" alt="Screenshot 2" width="300"/>
  </div>
  <div align="center">
    <img src="https://github.com/yagnik2411/Quiz-Genius/blob/master/assets/images/Screenshot_3.png" alt="Screenshot 3" width="300"/>
    <img src="https://github.com/yagnik2411/Quiz-Genius/blob/master/assets/images/Screenshot_4.png" alt="Screenshot 4" width="300"/>
  </div>  
</div>

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
## Contributing to Quiz Genius

Thank you for considering contributing to OpSo! We welcome contributions from the community to help improve the app and add new features. Below are some guidelines for contributing:

### Bug Reports and Feature Requests

If you encounter any bugs or have ideas for new features, please [open an issue](https://github.com/yourusername/OpSo/issues) on GitHub. Make sure to provide detailed information about the issue or feature request, including steps to reproduce the bug if applicable.

### Code Contributions

We appreciate any code contributions that enhance the functionality or improve the user experience of Quiz Genius. To contribute code, follow these steps:

1. Fork the repository to your GitHub account.
2. Clone your forked repository to your local machine.
3. Create a new branch for your feature or bug fix: `git checkout -b feature-name`.
4. Make your changes and ensure that the code follows the [Flutter style guide](https://flutter.dev/docs/development/tools/formatting).
5. Test your changes locally to ensure they work as expected.
6. Commit your changes with descriptive commit messages: `git commit -m "Add feature XYZ"`.
7. Push your changes to your forked repository: `git push origin feature-name`.
8. Create a pull request against the `main` branch of the original repository.

## Getting Started

To run the Quiz Genius app locally, you need to have Flutter and Dart installed on your machine. Follow these steps:

1. Clone this repository:

 ```bash
 git clone https://github.com/yagnik2411/Quiz-Genius.git
```

2. Navigate to the project's root directory:

```bash
cd Quiz-Genius
```

3. Install dependencies:

```bash
flutter pub get
``` 

4. Check for Flutter setup and connected devices:

```bash
flutter doctor
```

5. Run the app:

```bash
flutter run
```

## Contact

- [LinkedIn](https://www.linkedin.com/in/yagnikpanchal)
- [Email](mailto:panchalyagnik2411@gmail.com)

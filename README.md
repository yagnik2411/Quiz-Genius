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

Thank you for your interest in contributing to **Quiz Genius**! We greatly appreciate community involvement to help enhance the app and introduce new features. Whether you're reporting bugs or submitting code contributions, your input is valuable. For more detailed information on how to contribute, please refer to the [CONTRIBUTING.md](./CONTRIBUTING.md) file. Here are some guidelines to help you get started:

### Reporting Bugs and Requesting Features

If you encounter a bug or have a suggestion for a new feature, please [open an issue](https://github.com/yagnik2411/Quiz-Genius/issues/new). Provide as much detail as possible, including clear reproduction steps if it's a bug. This helps us better understand and address the problem or request.

### Code Contributions

Contributions that improve functionality or user experience are always welcome. Follow these steps to contribute:

1. **Fork** this repository to your GitHub account.
2. **Clone** your forked repository locally.
3. **Create a new branch** for your changes: `git checkout -b your-branch-name`.
4. Implement your changes, ensuring they adhere to the [Flutter style guide](https://docs.flutter.dev/guides/language/effective-dart).
5. **Test** your changes thoroughly to verify everything works correctly.
6. Commit your work with a detailed message: `git commit -m "Description of changes"`.
7. **Push** your branch to your GitHub fork: `git push origin your-branch-name`.
8. Submit a **pull request** to the main repository's `main` branch, describing the purpose and scope of your changes.

We look forward to your contributions!

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
---

## 👀 Our Contributors

- We extend our heartfelt gratitude for your invaluable contribution to our project! Your efforts play a pivotal role in elevating this project to greater heights.
- Make sure you show some love by giving ⭐ to our repository.

<div align="center">
  <a href="https://github.com/yagnik2411/Quiz-Genius">
    <img src="https://contrib.rocks/image?repo=yagnik2411/Quiz-Genius&&max=100" />
  </a>
</div>

---

## Contact

- [LinkedIn](https://www.linkedin.com/in/yagnikpanchal)
- [Email](mailto:panchalyagnik2411@gmail.com)

<div align="center">
  
# Quiz Genius - A Flutter Quiz App
<img  src="https://readme-typing-svg.herokuapp.com?color=2ecc71&center=true&vCenter=true&size=40&width=900&height=80&lines=Welcome+to+Quiz+Genius!"/>
</div>

**Quiz Genius** is a quiz app built with Flutter and Dart, designed to provide an engaging quiz experience with various features that enhance user interaction and performance tracking.

<!--Line-->
<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="900">

<!-- Added Hacktoberfest 2024 and GSSoC Extended 2024 banners -->

### This project is now OFFICIALLY accepted for

<table>

   <tr>
      <th>Event Logo</th>
      <th>Event Name</th>
      <th>Event Description</th>
   </tr>
   <tr>
      <td><img src="https://github.com/Annapoornaaradhya/Quiz-Genius/blob/README/assets/images/gssocextd.jpg" width="200" height="auto" loading="lazy" alt="GSSoC 24"/></td>
      <td>GirlScript Summer of Code 2024</td>
      <td>GirlScript Summer of Code is a three-month-long Open Source Program conducted every summer by GirlScript Foundation. It is an initiative to bring more beginners to Open-Source Software Development.</td>
   </tr>
    <tr>
      <td><img src="https://github.com/Annapoornaaradhya/Quiz-Genius/blob/README/assets/images/hacktoberfest.png" width="200" height="auto" loading="lazy" alt="Hacktoberfest 2024"/></td>
      <td>Hacktoberfest 2024</td>
      <td>Hacktoberfest is a month-long celebration of open source software run by DigitalOcean, GitHub, and Twilio. It encourages contributions to open source projects and promotes a global community of developers.</td>
   </tr>

</table>
<br/>

<!--Line-->
<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="900">

## Table of Contents

1. [UI Preview](#ui-preview)
2. [Features](#features)
3. [Technical Implementation](#technical-implementation)
4. [Example of API Structure](#example-of-api-structure)
5. [Contributing to Quiz Genius](#contributing-to-quiz-genius)
6. [Reporting Bugs and Requesting Features](#reporting-bugs-and-requesting-features)
7. [Code Contributions](#code-contributions)
8. [Getting Started](#getting-started)

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

<!--Line-->
<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="900">

## Features

- **User Profile:** Each user has a profile that saves their name and quiz performance for easy tracking.
- **Quiz History:** View previous quizzes and scores, allowing users to review past performance and questions.
- **Login & Data Saving:** User progress is saved through Firebase, ensuring continuity between sessions.
- **Take a Quiz:** Users can start a new quiz and test their knowledge on a variety of topics.

<!--Line-->
<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="900">

## Technical Implementation

- **User Login:** Authentication (login, sign-up, sign-in) is managed using Firebase Authentication.
- **Data Storage:** User data and quiz performance are stored securely using Cloud Firestore.
- **Questions Bank:** Quiz questions are fetched from a third-party API using JSON serialization to handle the data.
- **User-Friendly UI:** The app features a professional and intuitive UI, providing a seamless user experience.

<!--Line-->
<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="900">

## Example of API Structure 
### (Question Bank)

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

<!--Line-->
<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="900">

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

<!--Line-->
<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="900">

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
<br>

<!--Line-->
<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="900">


<div>
  <h2 align = "center"><img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Red%20Heart.png" width="35" height="35">Our Contributors</h2>
  <div align = "center">
    <h3>Thank you for contributing to our repository</h3>
      
  ![Contributors](https://contrib.rocks/image?repo=yagnik2411/Quiz-Genius&v=1)
  </div>
</div>

- We extend our heartfelt gratitude for your invaluable contribution to our project! Your efforts play a pivotal role in elevating this project to greater heights.
- Make sure you show some love by giving ⭐ to our repository.

<!--Line-->
<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="900">

<!-- Added: Team Section  -->
## 👥 Team

| ![Yagnik Panchal](https://avatars.githubusercontent.com/u/113328020?v=4&s=80) | ![Kirolos Mayiz Fahem](https://avatars.githubusercontent.com/u/72953174?v=4&s=80) |
|:--:|:--:|
| **Yagnik Panchal** <br> <sub>Project Admin</sub> | **Kirolos Mayiz Fahem** <br> <sub>Project Mentor</sub> |
| [![LinkedIn](https://img.icons8.com/fluency/32/000000/linkedin.png)](https://www.linkedin.com/in/yagnikpanchal) [![Gmail](https://img.icons8.com/fluency/32/000000/gmail.png)](mailto:panchalyagnik2411@gmail.com) | [![LinkedIn](https://img.icons8.com/fluency/32/000000/linkedin.png)](https://www.linkedin.com/in/kirolos-m/) |

For any inquiries or feedback, please contact. Happy Contributing 🫡

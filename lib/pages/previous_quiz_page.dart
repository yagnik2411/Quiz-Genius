import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:quiz_genius/models/previous_questions.dart';
import 'package:quiz_genius/utils/colors.dart';

// Stateful widget to display previous quiz questions
class PreviousQuiz extends StatefulWidget {
  const PreviousQuiz({Key? key}) : super(key: key);

  @override
  State<PreviousQuiz> createState() => _PreviousQuizState();
}

// Helper function to check if the answer is correct or incorrect
String checkAnswer(bool answer) {
  return answer ? "Correct" : "Incorrect";
}

// State class for PreviousQuiz widget
class _PreviousQuizState extends State<PreviousQuiz> {
  @override
  void initState() {
    super.initState();
    // Clear any previous questions in the list to avoid duplicate entries
    PreviousQuestions.questions.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: questionFetch(), // Fetch the previous questions from Firestore
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Once the future is completed, display the quiz history
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,  // Background color of the screen
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the previous screen
                },
                icon: const Icon(CupertinoIcons.back),
              ),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // AppBar color
              title: const Text("Quiz Genius").centered(), // Centered title in AppBar
            ),
            body: Container(
              height: (MediaQuery.of(context).size.height * 0.9).h, // Setting body height dynamically
              child: (PreviousQuestions.questions.isNotEmpty)
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.sp, horizontal: 16.sp), // Padding around the list
                      itemCount: PreviousQuestions.questions.length, // Number of items in the list
                      itemBuilder: (context, index) {
                        // Building each question widget
                        return Container(
                          padding: EdgeInsets.all(8.sp), // Padding inside the container
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: MyColors.darkCyan, width: 3.w), // Border styling
                            borderRadius: BorderRadius.circular(15.sp), // Rounded corners
                            color: MyColors.malachite.withOpacity(0.8), // Background color with opacity
                          ),
                          child: Column(
                            children: [
                              // Displaying each question
                              ListTile(
                                title: Text(
                                  PreviousQuestions.questions[index].question,
                                  style: TextStyle(
                                    color: MyColors.seashall, // Text color
                                    fontSize: 17.sp, // Font size
                                    fontWeight: FontWeight.values[5], // Font weight
                                  ),
                                  textWidthBasis: TextWidthBasis.parent, // Ensures text fits within parent width
                                ),
                              ),
                              SizedBox(
                                height: 10.h, // Space between question and answer
                              ),
                              // Displaying if the answer was correct or incorrect
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.sp, vertical: 10.sp), // Padding around the answer container
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white, width: 1), // Border styling for answer container
                                  borderRadius: BorderRadius.circular(15.sp), // Rounded corners
                                  color: MyColors.mint, // Background color
                                ),
                                child: Text(
                                  "${checkAnswer(PreviousQuestions.questions[index].correct)}", // Correct or Incorrect text
                                  style: TextStyle(
                                    color: MyColors.seashall, // Text color
                                    fontSize: 15.sp, // Font size for answer
                                    fontWeight: FontWeight.normal, // Normal font weight
                                  ),
                                  textWidthBasis: TextWidthBasis.parent,
                                ),
                              ),
                            ],
                          ),
                        ).py(5.sp); // Padding around the question container
                      },
                    )
                  : Center(
                      // If no previous questions are found
                      child: Text("No Previous Quizzes Found")
                          .text
                          .xl3
                          .color(MyColors.malachite)
                          .bold
                          .make()
                          .p(16.sp),
                    ),
            ),
          );
        } else {
          // While data is still loading, show a loading spinner
          return Container(
            decoration: const BoxDecoration(
              color: MyColors.lightCyan,
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: MyColors.malachite, // Spinner color
                backgroundColor: MyColors.lightCyan, // Spinner background color
              ),
            ),
          );
        }
      },
    );
  }

  // Function to fetch the previous quiz questions from Firestore
  Future<void> questionFetch() async {
    try {
      // Fetching user's previous questions from Firestore
      DocumentSnapshot data = await FirebaseFirestore.instance
          .collection("users") // Accessing the 'users' collection
          .doc(CurrentUser.currentUser.email) // Accessing the current user's document
          .collection("previousQuestions") // Accessing the 'previousQuestions' sub-collection
          .doc("Questions") // Accessing the 'Questions' document
          .get();

      // Check if the data exists and is valid
      if (data.exists && data['Questions'] != null) {
        List<dynamic> questionsData = data['Questions']; // Fetch the list of questions
        for (var question in questionsData) {
          // Convert each question map into a PreviousQuestion object and add it to the list
          PreviousQuestions.questions.add(PreviousQuestion.fromMap(question));
        }
      } else {
        print("No previous questions found in Firestore."); // Log if no questions found
      }
    } catch (e) {
      print("Error fetching previous questions: $e"); // Log any errors that occur
    }
  }
}

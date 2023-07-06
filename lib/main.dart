import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_genius/firebase_options.dart';
import 'package:quiz_genius/pages/home_page.dart';
import 'package:quiz_genius/pages/previous_quiz_page.dart';
import 'package:quiz_genius/pages/previous_scores_page.dart';
import 'package:quiz_genius/pages/profile_page.dart';
import 'package:quiz_genius/pages/quiz_page.dart';
import 'package:quiz_genius/pages/signUp_page.dart';
import 'package:quiz_genius/pages/username_page.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(
    
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        // fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: MyRoutes.quizRoute,
      routes: {
        MyRoutes.loginRoute: (context) => Login(),
        MyRoutes.usernameRoute: (context) =>  UserName(),
        MyRoutes.homeRoute: (context) =>  HomePage(),
        MyRoutes.quizRoute: (context) => const QuizPage(),
        MyRoutes.scoreRoute: (context) => const ScorePage(),
        MyRoutes.previousQuizRoute: (context) => const PreviousQuiz(),
        MyRoutes.profileRoute: (context) => const ProfilePage(),
        MyRoutes.signUpRoute: (context) => SignUp(),
      },
    );
  }
}

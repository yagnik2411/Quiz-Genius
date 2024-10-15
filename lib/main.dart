import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_genius/firebase_options.dart';
import 'package:quiz_genius/pages/home_page.dart';
import 'package:quiz_genius/pages/previous_quiz_page.dart';
import 'package:quiz_genius/pages/previous_scores_page.dart';
import 'package:quiz_genius/pages/profile_page.dart';
import 'package:quiz_genius/pages/quiz_mcq_page.dart';
import 'package:quiz_genius/pages/quiz_page.dart';
import 'package:quiz_genius/pages/signUp_page.dart';
import 'package:quiz_genius/pages/splash_screen.dart';
import 'package:quiz_genius/pages/username_page.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 873),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: ThemeData(
              fontFamily: GoogleFonts.montserrat().fontFamily,
              textTheme: TextTheme(
                  titleMedium: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ))),
          initialRoute: MyRoutes.splashScreenRoute,
          routes: {
            MyRoutes.loginRoute: (context) => Login(),
            MyRoutes.usernameRoute: (context) => UserName(),
            MyRoutes.homeRoute: (context) => HomePage(),
            // MyRoutes.quizRoute: (context) => QuizPage(),
            MyRoutes.scoreRoute: (context) => ScorePage(),
            MyRoutes.previousQuizRoute: (context) => const PreviousQuiz(),
            MyRoutes.profileRoute: (context) => const ProfilePage(),
            MyRoutes.signUpRoute: (context) => SignUp(),
            MyRoutes.splashScreenRoute: (context) => SplashScreen(),
            // MyRoutes.quizMCQRoute: (context) => QuizMCQPage(),
          },
        );
      },
    );
  }
}

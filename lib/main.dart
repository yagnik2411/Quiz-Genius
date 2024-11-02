// Importing necessary packages for the application
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
import 'package:quiz_genius/pages/signUp_page.dart';
import 'package:quiz_genius/pages/splash_screen.dart';
import 'package:quiz_genius/pages/username_page.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'pages/login_page.dart';

// Main entry point of the app
Future<void> main() async {
  // Ensures that widget binding is initialized (necessary for async calls before runApp)
  WidgetsFlutterBinding.ensureInitialized();

  // Locks the screen orientation to portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initializes Firebase with platform-specific configurations (from firebase_options.dart)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Launches the main Flutter application by calling MyApp
  runApp(const MyApp());
}

// The root widget of the application
class MyApp extends StatelessWidget {
  // Constructor to initialize the MyApp widget
  const MyApp({super.key});
  // The build method returns the UI that MyApp should display
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Defines the design size for responsive scaling (393x873 is the base design size)
      designSize: const Size(393, 873),
      // Ensures that text scales appropriately for different screen sizes
      minTextAdapt: true,
      // Allows the app to support split-screen mode
      splitScreenMode: true,
      // builder function creates the MaterialApp widget (the actual app)
      builder: (_, child) {
        return MaterialApp(
          // Disables the debug banner seen in the top-right corner during development
          debugShowCheckedModeBanner: false,
          // Sets the default theme mode to light
          themeMode: ThemeMode.light,
          // Defines the theme for the app, including font styles and colors
          theme: ThemeData(
              // Uses Montserrat font throughout the app
              fontFamily: GoogleFonts.montserrat().fontFamily,
              // Sets a custom text style for medium-sized titles (used throughout the app)
              textTheme: TextTheme(
                  titleMedium: TextStyle(
                fontSize: 20.sp, // Responsive font size
                color: Colors.black, // Black text color
                fontWeight: FontWeight.w800, // Bold font weight
              ))),
          // Initial route of the app when it starts (Splash Screen)
          initialRoute: MyRoutes.splashScreenRoute,
          // Defines the navigation routes for different screens in the app
          routes: {
            MyRoutes.loginRoute: (context) => Login(), // Navigates to Login page
            MyRoutes.usernameRoute: (context) => UserName(), // Navigates to Username setup page
            MyRoutes.homeRoute: (context) => HomePage(), // Navigates to Home page
            MyRoutes.scoreRoute: (context) => ScorePage(), // Navigates to Previous Scores page
            MyRoutes.previousQuizRoute: (context) => const PreviousQuiz(), // Navigates to Previous Quiz page
            MyRoutes.profileRoute: (context) => const ProfilePage(), // Navigates to Profile page
            MyRoutes.signUpRoute: (context) => SignUp(), // Navigates to Sign-up page
            MyRoutes.splashScreenRoute: (context) => SplashScreen(), // Navigates to Splash Screen page
          },
        );
      },
    );
  }
}
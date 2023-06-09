import 'package:flutter/material.dart';
import 'package:quiz_genius/pages/username_page.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login_page.dart';

void main() {
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
      initialRoute: MyRoutes.usernameRoute,
      routes: {
        MyRoutes.loginRoute: (context) => const Login(),
        MyRoutes.usernameRoute: (context) => const UserName(),
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:quiz_genius/utils/my_route.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and the animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _animationController.forward();

    // Listen for the completion of the fade-in animation
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Start the fade-out animation
       
          _animationController.reverse();

          
        
      } else if (status == AnimationStatus.dismissed) {
        // Navigate to login screen after fade-out animation completes
        Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
      }
    });
  }

  @override
  void dispose() {
    // Dispose the animation controller
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset('assets/images/icon.png', width: 200, height: 200),
          ),
        ),
      ),
    );
  }
}

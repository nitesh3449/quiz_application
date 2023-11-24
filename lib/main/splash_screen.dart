import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_application/authentication/login/routes/login_screen.dart';
import 'package:quiz_application/quizScreen/quiz_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const QuizStartScreen()
        )
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            "assets/ic_splash_logo.png"
          ),
        ),
      ),
    );
  }
}

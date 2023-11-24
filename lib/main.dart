import 'package:flutter/material.dart';
import 'package:quiz_application/main/splash_screen.dart';
import 'package:quiz_application/quizScreen/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primaryColor: Colors.amberAccent,
        secondaryHeaderColor: Colors.amberAccent
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:quiz_application/authentication/login/routes/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.amberAccent,
        body: Center(
          child: GestureDetector(
            onTap: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()
                    )
                );
            },
            child: const Text(
              "SignUp",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),
            ),
          ),
        ),
    );
  }
}

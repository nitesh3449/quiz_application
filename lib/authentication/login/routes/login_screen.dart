import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_application/authentication/signup/routes/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.asset(
                  "assets/ic_splash_logo.png",
                height: 220,
                width: 300,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.amberAccent
                    ),
                  ),

                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "User Name",
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      hintText: "User Name",
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        child: Icon(
                            isObscure
                            ? FontAwesomeIcons.solidEye
                                : FontAwesomeIcons.eyeSlash,
                          size: 18,
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()
                    )
                );
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

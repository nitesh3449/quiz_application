import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_application/constants/app_constants.dart';
import 'package:quiz_application/preferences/app_preferences.dart';
import 'package:quiz_application/quizScreen/question_screen.dart';
import 'package:quiz_application/quizScreen/result_screen.dart';

class QuizStartScreen extends StatefulWidget {
  const QuizStartScreen({super.key});

  @override
  State<QuizStartScreen> createState() => _QuizStartScreenState();
}

class _QuizStartScreenState extends State<QuizStartScreen> {
  double bestScore = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPreferencesData();
  }

  void getPreferencesData() async {
     bestScore = await PreferenceHelper.getDoublePreferencesData(PreferenceHelper.bestScore) ?? -1;
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text(
          "Quiz",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: TextSize.headerSize),
        ),
        actions: [
          Visibility(
            visible: bestScore != -1,
            child: GestureDetector(
              onTap: () {
                PreferenceHelper.clearPreferenceData(PreferenceHelper.questionList);
                PreferenceHelper.clearPreferenceData(PreferenceHelper.bestScore);
                PreferenceHelper.clearPreferenceData(PreferenceHelper.percentage);

                bestScore =  -1;
                setState(() {});
              },
              child:  Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Clear Result",
                  style: TextStyle(
                    fontSize: TextSize.smallFont,
                    color: AppColor.fontColor,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                  "assets/ic_splash_logo.png",
                height: 150,
                width: 300,
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.greyColor,
                    blurRadius: 10,
                    spreadRadius: 0.5,
                    offset: Offset(0,1)
                  )
                ]
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: Text(
                      "Quiz 1",
                      style: TextStyle(
                          fontSize: TextSize.mediumFont,
                          fontWeight: FontWeight.bold,
                          color: AppColor.fontColor
                      ),
                    ),
                  ),
                    getQuizInstructionWithIcon(iconName: FontAwesomeIcons.medal, title: "Result required: 65%"),
                    getQuizInstructionWithIcon(iconName: Icons.timer_sharp, title: "Time limit: Unlimited"),
                    getQuizInstructionWithIcon(iconName: FontAwesomeIcons.waveSquare, title: "Attempts remaining: Unlimited"),

                  const SizedBox(height: 16,),
                  const Divider(height: 1, thickness: 1, color: Colors.grey,),
                  const SizedBox(height: 16,),

                  GestureDetector(
                    onTap: (){
                      if(bestScore == -1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuestionScreen()
                            )
                        ).then((value) async {
                          log("Hello");
                          bestScore = await PreferenceHelper.getDoublePreferencesData(PreferenceHelper.bestScore) ?? -1;

                          log("Best Score====$bestScore");
                          setState(() {});
                        });
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ResultScreen()
                            )
                        ).then((value) async {
                          bestScore = await PreferenceHelper.getDoublePreferencesData(PreferenceHelper.bestScore) ?? -1;

                          log("Best Score==123==$bestScore");
                          log("Best Score==1111==$bestScore");
                          setState(() {});
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        bestScore == -1
                        ? "Start Quiz"
                        : "Review Result",
                        style: const TextStyle(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: TextSize.buttonFont
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Visibility(
              visible: bestScore != -1,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    "Best Score - ${bestScore.toStringAsFixed(0)} %",
                    style:  TextStyle(
                        color: AppColor.fontColor.withOpacity(0.54),
                        fontWeight: FontWeight.bold,
                        fontSize: TextSize.mediumFont
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getQuizInstructionWithIcon({required iconName, required title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(iconName, size: 16,),
          const SizedBox(width: 8,),
          Text(
            "$title",
            style: const TextStyle(
                fontSize: TextSize.normalFont,
                fontWeight: FontWeight.w500,
                color: AppColor.fontColor
            ),
          ),
        ],
      ),
    );
  }

}


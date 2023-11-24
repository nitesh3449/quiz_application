import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_application/constants/app_constants.dart';
import 'package:quiz_application/preferences/app_preferences.dart';
import 'package:quiz_application/quizScreen/question_screen.dart';
import 'package:quiz_application/quizScreen/result_details_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var progressValue = 0.0;
  double percentageData = -1.0;
  Timer? timer;
  bool isPassed = true;

  @override
  void initState() {
    super.initState();

    getPreferenceData();
  }

  void getPreferenceData() async {
     percentageData = await PreferenceHelper.getDoublePreferencesData(PreferenceHelper.percentage) ?? 0;

    isPassed = percentageData  > 65.0;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      progressValue = progressValue + 0.01;
      if(percentageData == 0.0) {
        progressValue = 0.0;
        timer.cancel();
      } else if (progressValue.toStringAsFixed(2) == (percentageData/100).toStringAsFixed(2)) {
        timer.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text(
          "Result",
          style: TextStyle(
              color: AppColor.whiteColor, fontWeight: FontWeight.w700, fontSize: TextSize.headerSize),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, size: 24, color: AppColor.whiteColor,),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 32),
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColor.greyColor,
                        blurRadius: 10,
                        spreadRadius: 0.5,
                        offset: Offset(0, 1))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: CircularProgressIndicator(
                          value: progressValue,
                          backgroundColor: AppColor.greyColor,
                          color: AppColor.primaryColor,
                          strokeWidth: 7,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32),
                            ),
                            child: isPassed 
                            ? const Icon(
                              Icons.check_circle,
                              color: AppColor.greenColor,
                              size: 32,
                            )
                            : const Icon(
                              Icons.cancel,
                              color: AppColor.redColor,
                              size: 32,
                            ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: (progressValue*100).toStringAsFixed(0),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.fontColor,
                                    fontSize: 32,
                                    letterSpacing: 0.0
                                  ),
                                ),
                                const TextSpan(
                                  text:  " %",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.fontColor,
                                    fontSize: TextSize.normalFont,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16,),

                  Text(
                   isPassed ?  "Congratulations!" : "Failed",
                    style:  TextStyle(
                      color: isPassed ? AppColor.fontColor : AppColor.redColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16,),

                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:  isPassed ? "You have passed " : "You have failed ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColor.fontColor.withOpacity(0.6),
                              fontSize: TextSize.normalFont,
                              letterSpacing: 0.0
                          ),
                        ),
                        const TextSpan(
                          text:  "Quiz 1",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColor.fontColor,
                            fontSize: TextSize.normalFont,
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 0,),

                  GestureDetector(
                    onTap: () async {
                      var data = await PreferenceHelper.getPreferencesData(PreferenceHelper.questionList)?? "";
                      List resultListData = json.decode(data);

                      if(mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ResultDetailsScreen(
                                  resultListData: resultListData,
                                ),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 2),
                      child: Text(
                        "Click here to review your results & feedback",
                        style: TextStyle(
                          color: AppColor.fontColor.withOpacity(0.54),
                          fontSize: TextSize.smallFont,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Divider(height: 1,color: AppColor.dividerColor, thickness: 1,),
                  ),
                ],
              ),
            ),

            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuestionScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Re-Attempt Quiz",
                    style: TextStyle(
                        color: AppColor.whiteColor,
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
}

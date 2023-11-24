import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_application/constants/app_constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quiz_application/preferences/app_preferences.dart';
import 'package:quiz_application/quizScreen/result_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final ScrollController _controller = ScrollController();
  final BoxDecoration _selectedDecoration = AppConstants.selectedDecoration;
  final BoxDecoration _unSelectedDecoration = AppConstants.unSelectedDecoration;

  int currentIndex = 0;

  List questionList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchQuestionData();
  }

  void fetchQuestionData() async {
    var resultData =
        await rootBundle.loadString('assets/question_option_list.json');
    var data = json.decode(resultData);
    setState(() {
      questionList = data['data'] ?? [];
    });

    log("QuestionScreen===$questionList");
  }

  void movePrevious() {
    _controller.animateTo(
        _controller.offset - MediaQuery.of(context).size.width,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 200));

    if (currentIndex > 0) currentIndex--;
    debugPrint("IndexPosition===$currentIndex");
  }

  void moveNext() {
    _controller.animateTo(
        _controller.offset + MediaQuery.of(context).size.width,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 200));

    if (currentIndex < questionList.length) currentIndex++;
    debugPrint("IndexPosition===$currentIndex");
  }

  void onSelected(int index, int subIndex) {
    for (int i = 0; i < questionList[index]['options'].length; i++) {
      questionList[index]['options'][i]['optionStatus'] = false;
    }
    questionList[index]['options'][subIndex]['optionStatus'] = true;

    if (questionList[index]['options'][subIndex]['isCorrect'] == questionList[index]['options'][subIndex]['optionStatus']) {
      questionList[index]['score'] = 1;
    } else {
      questionList[index]['score'] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text(
          "Quiz 1",
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
      body: ListView.builder(
        controller: _controller,
        itemCount: questionList.length,
        itemExtent: MediaQuery.of(context).size.width,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: NeverScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.greyColor.withOpacity(0.3)),
                  child: Text(
                    "${index + 1} of ${questionList.length}",
                    style: const TextStyle(
                      fontSize: TextSize.smallFont,
                        fontWeight: FontWeight.w600, color: AppColor.fontColor),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    "${questionList[index]['question']}",
                    // "There is some task to do, we need to transfer some data from one station to another station, due to offices are remain close till saturday, Office will open inb next friday, so pleASE KEEP calm any stay safe in your house.",
                    style: const TextStyle(
                      fontSize: TextSize.normalFont,
                        fontWeight: FontWeight.w600, color: AppColor.fontColor),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                  itemCount: questionList[index]['options'].length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, subIndex) {
                    return GestureDetector(
                      onTap: () {
                        onSelected(index, subIndex);

                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        decoration: questionList[index]['options'][subIndex]['optionStatus']
                            ? AppConstants.selectedDecoration
                            : AppConstants.unSelectedDecoration,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 28,
                              height: 28,
                              child: CircleAvatar(
                                backgroundColor:  questionList[index]['options'][subIndex]['optionStatus']
                                     ? AppColor.selectedColor
                                     : AppColor.unSelectedColor,
                                child: Text(
                                  String.fromCharCode(subIndex + 65),
                                  style: const TextStyle(
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: TextSize.xSmallFont),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "${questionList[index]['options'][subIndex]['option']}",
                                style: const TextStyle(
                                    color: AppColor.fontColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: TextSize.smallFont),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentIndex != 0
                          ? getCustomButton(
                              onPressed: () {
                                movePrevious();
                                setState(() {});
                              },
                              title: "Previous",
                            )
                          : Container(),
                      currentIndex != 2
                          ? getCustomButton(
                              title: "Next",
                              onPressed: () {
                                moveNext();
                                setState(() {});
                              },
                            )
                          : getCustomButton(
                              title: "Finish",
                              onPressed: () {
                                calculateResult();
                              },
                            ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getCustomButton({title, onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: title == "Finish" ?  AppColor.primaryColor : AppColor.greyColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColor.whiteColor,
            fontSize: TextSize.buttonFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void calculateResult() async {
    var score = 0;
    for (int i = 0; i < questionList.length; i++) {
      score = score + int.parse("${questionList[i]['score']}");
    }
    var percentage = (score / questionList.length) * 100;
    log("Percentage====$percentage");

    PreferenceHelper.setPreferencesData(PreferenceHelper.questionList, json.encode(questionList));
    PreferenceHelper.setDoublePreferencesData(PreferenceHelper.percentage, percentage);

    double bestScore = await PreferenceHelper.getDoublePreferencesData(PreferenceHelper.bestScore) ?? 0;
    if(bestScore <= percentage) {
      PreferenceHelper.setDoublePreferencesData(PreferenceHelper.bestScore, percentage);
    }

    if(mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResultScreen(),
        ),
      );
    }
  }
}

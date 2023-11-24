import 'package:flutter/material.dart';
import 'package:quiz_application/constants/app_constants.dart';

class ResultDetailsScreen extends StatefulWidget {
  final List resultListData;
  const ResultDetailsScreen({super.key, required this.resultListData});

  @override
  State<ResultDetailsScreen> createState() => _ResultDetailsScreenState();
}

class _ResultDetailsScreenState extends State<ResultDetailsScreen> {
  List? resultListData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    resultListData = widget.resultListData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text(
          "Result Summary",
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: resultListData != null
          ? Container(
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
                ],
            ),
            child: ListView.builder(
              itemCount: resultListData!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(left: 16,right: 16, top: 16 ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${index+1}.",
                            style: const TextStyle(
                                color: AppColor.fontColor,
                                fontWeight: FontWeight.w600,
                                fontSize: TextSize.normalFont,
                            ),
                          ),
                          const SizedBox(width: 8,),
                          Expanded(
                            child: Text(
                              "${resultListData![index]['question']}",
                              style: const TextStyle(
                                fontSize: TextSize.normalFont,
                                  fontWeight: FontWeight.w500, color: AppColor.fontColor),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 10,),

                      ListView.builder(
                        itemCount: resultListData![index]['options'].length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, subIndex) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            decoration: !resultListData![index]['options'][subIndex]['isCorrect'] && resultListData![index]['options'][subIndex]['optionStatus']
                                ? AppConstants.incorrectDecoration
                                : resultListData![index]['options'][subIndex]['optionStatus']
                                ? AppConstants.selectedDecoration
                                : AppConstants.unSelectedDecoration,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: CircleAvatar(
                                    backgroundColor: !resultListData![index]['options'][subIndex]['isCorrect'] && resultListData![index]['options'][subIndex]['optionStatus']
                                    ? Colors.red
                                    : resultListData![index]['options'][subIndex]['optionStatus']
                                    ? Colors.green.shade700
                                    : Colors.grey,
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
                                    "${resultListData![index]['options'][subIndex]['option']}",
                                    style: const TextStyle(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: TextSize.smallFont),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ) ,
                );
              },
            ),
          )
          : Container(),
        ),
      ),
    );
  }
}

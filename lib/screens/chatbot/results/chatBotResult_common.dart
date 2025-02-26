import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/model/raderChart.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/widgets/circleTitleItem.dart';
import 'package:ticklemickle_m/common/widgets/commonHighlightText.dart';
import 'package:ticklemickle_m/common/widgets/commonShareLink.dart';
import 'package:ticklemickle_m/common/widgets/roundTextButton.dart';
import 'package:ticklemickle_m/screens/chatbot/results/answerList/common_FinanceList.dart';
import 'package:ticklemickle_m/common/widgets/commonAppBar.dart';

class ChatBotResultCommon extends StatelessWidget {
  const ChatBotResultCommon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> labels = ['공격성', '기대\n수익률', '지식', '트랜드', '투자\n금액'];
    // 5점 척도라고 가정 (maxValue = 5)
    final List<double> sampleValues = [5, 1, 2, 3.5, 3];
    final random = Random();
    final result = commonFinanceList[random.nextInt(3)];
    final double maxValue = 5;

    return Scaffold(
        appBar: CommonAppBar(
          title: '국내 주식 성향 분석 결과',
          useAppHome: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Column(
                  children: [
                    Center(
                      child: CommonHighlightText(
                        leadingText: "홍길동 님은 ",
                        highlightedText: "독수리 투자자",
                        trailingText: " 입니다.",
                      ),
                    ),
                    RadarChart(
                      values: sampleValues,
                      maxValue: maxValue,
                      labels: labels,
                      chartSize: 200,
                    ),
                    Center(
                        child: Text("나와 비슷한 투자 성향을 가진 사람들은?",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CircleTitleItem(
                          title: "삼성전자",
                          imagePath: "assets/chatbot/result/logo/samsung.png",
                          defaultColor: Colors.blue,
                        ),
                        CircleTitleItem(
                          title: "카카오",
                          imagePath: "assets/chatbot/result/logo/kakao.png",
                          defaultColor: Colors.yellow,
                        ),
                        CircleTitleItem(
                          title: "롯데건설",
                          imagePath: "assets/chatbot/result/logo/lotte.png",
                          defaultColor: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    Column(children: [
                      Text("나와 가장 잘 어울리는 성향?",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 20),
                      Center(
                          child: Text(result.image,
                              style: const TextStyle(fontSize: 60))),
                      const SizedBox(height: 8),
                      Center(
                          child: Text(result.sub,
                              style: const TextStyle(fontSize: 16))),
                      const SizedBox(height: 8),
                      Center(
                          child: Text(result.title,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600))),
                      const SizedBox(height: 12),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: 60,
                                height: 2,
                                color: MyColors.mainDarkColor),
                            SizedBox(height: 4),
                            Text(result.match,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: MyColors.mainDarkColor)),
                            SizedBox(height: 4),
                            Container(
                                width: 60,
                                height: 2,
                                color: MyColors.mainDarkColor),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(result.description,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 16)),
                      ),
                    ]),
                    const SizedBox(height: 50),
                    Commonsharelink(),
                    const SizedBox(height: 70),
                    Center(
                      child: RoundedTextButton(
                        text: '다른 분석 결과 보기',
                        onPressed: () {
                          context.go("/AppHome");
                        },
                        backgroundColor: MyColors.mainColor,
                        textColor: Colors.black,
                        borderRadius: 10.0,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ))));
  }
}

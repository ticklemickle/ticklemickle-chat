import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/model/jsonToFinanceCommon.dart';
import 'package:ticklemickle_m/common/model/raderChart.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/utils/const.dart';
import 'package:ticklemickle_m/common/widgets/circleTitleItem.dart';
import 'package:ticklemickle_m/common/widgets/commonCard.dart';
import 'package:ticklemickle_m/common/widgets/commonHighlightText.dart';
import 'package:ticklemickle_m/common/widgets/commonShareLink.dart';
import 'package:ticklemickle_m/screens/chatbot/results/answerList/common_answerList.dart';
import 'package:ticklemickle_m/common/widgets/commonAppBar.dart';
import 'package:ticklemickle_m/screens/chatbot/results/answerList/linkResult.dart';
import 'package:ticklemickle_m/screens/chatbot/results/answerList/type_StockInvestor.dart';
import 'package:ticklemickle_m/screens/home/appList/appfinanceList.dart';

class ChatBotResultCommon extends StatefulWidget {
  final String category;
  final List<double> scoreList;

  const ChatBotResultCommon({
    Key? key,
    required this.category,
    required this.scoreList,
  }) : super(key: key);

  @override
  _ChatBotResultCommonState createState() => _ChatBotResultCommonState();
}

class _ChatBotResultCommonState extends State<ChatBotResultCommon> {
  late Future<Map<String, dynamic>> _dataFuture;
  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData();
  }

  Future<Map<String, dynamic>> _loadData() async {
    final random = Random();
    final List<double> resultValues = widget.scoreList;
    final double maxValue = 5;
    late final List<String> labels;
    late final dynamic result;
    late final dynamic match_result;
    late final dynamic circleImage;

    if (widget.category == CategoryConst.questionsBasicStatus ||
        widget.category == CategoryConst.questionsKoreaStockInvestment ||
        widget.category == CategoryConst.questionsUSAStockInvestment ||
        widget.category == CategoryConst.questionsCrypto) {
      labels = ['공격성', '기대\n수익률', '보유\n기간', '지식', '투자\n금액'];
      result = await mapInvestorResult(
        aggression: widget.scoreList[0],
        ret: widget.scoreList[1],
        period: widget.scoreList[2],
        knowledge: widget.scoreList[3],
        amount: widget.scoreList[4],
      );
      match_result =
          commonStockList[random.nextInt(commonStockList.length - 1)];
      circleImage = const [
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
      ];
    } else if (widget.category == CategoryConst.questionsRealEstateCommercial ||
        widget.category == CategoryConst.questionsRealEstateResidential) {
      labels = ['공격성', '기대\n수익률', '지식', '투자기간', '투자\n금액'];
      result = commonHousingList[random.nextInt(6)];
      match_result = commonHousingList[random.nextInt(6)];
      circleImage = const [
        CircleTitleItem(
          title: "연령대",
          content: "2030",
        ),
        CircleTitleItem(
          title: "지역",
          content: "서초\n광교",
        ),
        CircleTitleItem(
          title: "투자금",
          content: "1~3억",
        ),
      ];
    } else {
      labels = ['공격성', '기대\n수익률', '지식', '투자기간', '투자\n금액'];
      result = commonHousingList[random.nextInt(6)];
      match_result = commonHousingList[random.nextInt(6)];
      circleImage = const [
        CircleTitleItem(
          title: "연령대",
          content: "2030",
        ),
        CircleTitleItem(
          title: "지역",
          content: "서초\n광교",
        ),
        CircleTitleItem(
          title: "투자금",
          content: "1~3억",
        ),
      ];
    }

    return {
      'labels': labels,
      'result': result,
      'match_result': match_result,
      'circleImage': circleImage,
      'resultValues': resultValues,
      'maxValue': maxValue,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: getCategoryObject(widget.category)["title"] + ' 결과',
        useAppHome: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("데이터 로딩 오류: ${snapshot.error}"));
          }

          // Future가 반환한 데이터를 사용하여 UI 구성
          final data = snapshot.data!;
          final List<String> labels = data['labels'] as List<String>;
          final JsonToResultCommon result =
              data['result'] as JsonToResultCommon;
          final dynamic match_result = data['match_result'];
          final List<Widget> circleImage = data['circleImage'] as List<Widget>;
          final List<double> resultValues =
              data['resultValues'] as List<double>;
          final double maxValue = data['maxValue'] as double;

          // commonCardResult가 누락되어 있던 부분을 추가합니다.
          final commonCardResult = getchatBotResultLink(jsonList: [
            {
              "level": 2,
              "title": "${_removeLastCharacterIfHyung(result.title)} 유형 끼리 모임",
            },
          ]);

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Text(result.image,
                        style: const TextStyle(fontSize: 60)),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: CommonHighlightText(
                      leadingText: "홍길동 님은 ",
                      highlightedText: result.title,
                      trailingText: " 입니다.",
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child:
                        Text(result.sub, style: const TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(result.description,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 16)),
                  ),
                  RadarChart(
                    values: resultValues,
                    maxValue: maxValue,
                    labels: labels,
                    chartSize: 200,
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Text("나와 비슷한 투자 성향을 가진 사람들은?",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: circleImage,
                  ),
                  const SizedBox(height: 70),
                  Column(
                    children: [
                      Text("나와 가장 잘 어울리는 성향?",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(match_result.image,
                            style: const TextStyle(fontSize: 60)),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(match_result.sub,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(match_result.title,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: 60,
                                height: 2,
                                color: MyColors.mainDarkColor),
                            const SizedBox(height: 4),
                            Text(match_result.match,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: MyColors.mainDarkColor)),
                            const SizedBox(height: 4),
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
                        child: Text(match_result.description,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Commonsharelink(),
                  const SizedBox(height: 100),
                  // commonCardResult가 정상적으로 정의되어 사용됩니다.
                  for (var link in commonCardResult.links)
                    CommonCard(
                      imagePath: link.imagePath,
                      title: link.title ?? "",
                      subtitle: link.detail,
                      onTap: () => handleCardTap(context, link),
                    ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _removeLastCharacterIfHyung(String title) {
    if (title.isNotEmpty && title.endsWith('형')) {
      return title.substring(0, title.length - 1);
    }
    return title;
  }
}

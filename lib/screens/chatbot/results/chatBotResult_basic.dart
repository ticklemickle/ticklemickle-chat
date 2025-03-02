import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/model/raderChart.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/utils/const.dart';
import 'package:ticklemickle_m/common/widgets/commonHighlightText.dart';
import 'package:ticklemickle_m/common/widgets/commonShareLink.dart';
import 'package:ticklemickle_m/common/widgets/commonTitleAndContent.dart';
import 'package:ticklemickle_m/common/widgets/roundTextButton.dart';
import 'package:ticklemickle_m/screens/chatbot/results/answerList/comparsion_barList.dart';
import 'package:ticklemickle_m/screens/chatbot/widget/comparisonBarWidget.dart';
import 'package:ticklemickle_m/common/widgets/commonAppBar.dart';

class ChatBotResultBasic extends StatelessWidget {
  const ChatBotResultBasic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> labels = ['자산', '소비', '가능성', '관심', '소득'];
    // 5점 척도라고 가정 (maxValue = 5)
    final List<double> sampleValues = [3, 2, 4, 5, 3];
    final double maxValue = 5;

    return Scaffold(
        appBar: CommonAppBar(
          title: '재테크 현황 결과',
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
                        highlightedText: "발전 가능형",
                        trailingText: " 입니다.",
                      ),
                    ),
                    RadarChart(
                      values: sampleValues,
                      maxValue: maxValue,
                      labels: labels,
                      chartSize: 200,
                    ),
                    Row(children: [
                      Text("2030 남성 평균과 비교",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600))
                    ]),
                    const SizedBox(height: 35),
                    Wrap(
                      spacing: 5,
                      runSpacing: 70,
                      children: chartDataList.map((data) {
                        // 화면 가로 길이와 패딩/간격을 고려해 각 아이템의 width 계산
                        final width =
                            (MediaQuery.of(context).size.width - 16 * 2 - 16) /
                                2;
                        return SizedBox(
                          width: width,
                          child: ComparisonBarChart(data: data),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 70),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextWidget(
                              title: '강점',
                              content:
                                  '재테크에 또래 대비하여 관심도가 높은 편 입니다. 지속적인 관심이 있다면 높은 자산을 형성할 가능성이 매우 높은 유형입니다. '
                                  '투자 금액이 평균 소득 대비하여 102만원 (12%) 많은 것으로 분석되었습니다.',
                              highlightWords: ['102만원', '(12%)'],
                              highlightColor: MyColors.highlightFontColor),
                          CommonTextWidget(
                              title: '보완점',
                              content:
                                  '단기 소비 성향이 과도한 편에 속합니다. 평균과 대비하여 변동 지출이 큰 것은 향후 자산 형성에 불리할 수 있습니다.'
                                  '또래 평균 매월 59만원의 소비 패턴을 보인 것에 대비하여 13만원 (31%) 더 많이 소비 성향을 보이고 있습니다. ',
                              highlightWords: ['평균 매월 59만원의', '13만원 (31%) %'],
                              highlightColor: MyColors.highlightFontColor),
                        ]),
                    const SizedBox(height: 50),
                    Commonsharelink(),
                    const SizedBox(height: 70),
                    Center(
                      child: RoundedTextButton(
                        text: '다른 분석 결과 보기',
                        onPressed: () {
                          context.go(RouteConst.appHome);
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

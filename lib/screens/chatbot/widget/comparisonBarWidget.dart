import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/model/comparsionChart.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

class ComparisonBarChart extends StatelessWidget {
  final ComparisonData data;
  final double maxBarHeight;
  final double barWidth = 25.0;

  const ComparisonBarChart({
    Key? key,
    required this.data,
    this.maxBarHeight = 100.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 가장 큰 값
    final maxValue =
        (data.averageValue > data.myValue) ? data.averageValue : data.myValue;

    // 비율 계산
    final avgRatio = data.averageValue / maxValue;
    final myRatio = data.myValue / maxValue;

    // 실제 막대 높이
    final avgBarHeight = avgRatio * maxBarHeight;
    final myBarHeight = myRatio * maxBarHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 차트 제목
        Text(
          data.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        // 막대 영역
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // 평균 막대
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(data.averageLabel, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                Container(
                    width: barWidth, height: avgBarHeight, color: Colors.grey),
                const SizedBox(height: 4),
                const Text('평균', style: TextStyle(fontSize: 11)),
              ],
            ),
            // 내 막대
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(data.myLabel, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                Container(
                    width: barWidth,
                    height: myBarHeight,
                    color: MyColors.mainDarkColor),
                const SizedBox(height: 4),
                const Text('나', style: TextStyle(fontSize: 11)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

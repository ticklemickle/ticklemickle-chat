import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  final List<BarChartGroupData> barGroups;

  const BarChartWidget({Key? key, required this.barGroups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 1200,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          //   bottomTitles: SideTitles(
          //     showTitles: true,
          //     getTitles: (double value) {
          //       // x 값에 따른 라벨 지정 (예시: 0:'자산', 1:'저축', 2:'부채')
          //       switch (value.toInt()) {
          //         case 0:
          //           return '자산';
          //         case 1:
          //           return '저축';
          //         case 2:
          //           return '부채';
          //         default:
          //           return '';
          //       }
          //     },
          //     textStyle: TextStyle(fontSize: 14),
          //   ),
          //   leftTitles: SideTitles(
          //     showTitles: true,
          //     textStyle: TextStyle(fontSize: 12),
          //   ),
          // ),
          // borderData: FlBorderData(show: false),
          // barGroups: barGroups,
        ),
      ),
    );
  }
}

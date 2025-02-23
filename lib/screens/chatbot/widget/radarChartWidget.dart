import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

class RadarChartWidget extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final double maxValue;

  const RadarChartWidget({
    Key? key,
    required this.values,
    required this.labels,
    this.maxValue = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int count = values.length;
    const double size = 300; // 차트 영역의 크기 (정사각형)
    final center = Offset(size / 2, size / 2);
    final double radius = size / 2; // 최대 반경

    // 각 값에 대해 극좌표를 계산하여 화면 좌표(FlSpot)로 변환
    List<FlSpot> spots = [];
    for (int i = 0; i < count; i++) {
      double angle = (2 * pi / count) * i - pi / 2; // 시작 각도를 -pi/2로 하여 위쪽부터 시작
      double r = (values[i] / maxValue) * radius;
      double x = center.dx + r * cos(angle);
      double y = center.dy + r * sin(angle);
      spots.add(FlSpot(x, y));
    }
    // 다각형을 닫기 위해 첫 번째 점을 다시 추가
    spots.add(spots[0]);

    return Container(
      width: size,
      height: size,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: size,
          minY: 0,
          maxY: size,
          // 축, 그리드, 테두리는 보이지 않도록 설정
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: false,
              // color: [Colors.blue],
              barWidth: 2,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                // color: [Colors.blue.withOpacity(0.3)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

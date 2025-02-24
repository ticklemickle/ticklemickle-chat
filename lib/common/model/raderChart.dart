import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/model/radarChartPainter.dart';
import 'dart:math' as math;

class RadarChart extends StatelessWidget {
  /// 예: [자산, 소비, 가능성, 관심, 소득] 순으로 5개의 값
  final List<double> values;

  /// 각 꼭짓점 라벨(값의 순서와 동일해야 함)
  final List<String>? labels;

  /// values 중 최댓값 기준 (예: 5점 척도, 10점 척도 등)
  final double maxValue;

  /// 차트 크기 지정(고정 크기 예시)
  final double chartSize;

  const RadarChart({
    Key? key,
    required this.values,
    required this.maxValue,
    this.labels,
    required this.chartSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 70),
      CustomPaint(
        size: Size(chartSize, chartSize),
        painter: RadarChartPainter(
          values: values,
          maxValue: maxValue,
          labels: labels,
        ),
      ),
      const SizedBox(height: 100),
    ]);
  }
}

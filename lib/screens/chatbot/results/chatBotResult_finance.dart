import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/model/raderChart.dart';

class ChatBotResultFinance extends StatelessWidget {
  const ChatBotResultFinance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> labels = ['자산', '소비', '가능성', '관심', '소득'];
    // 5점 척도라고 가정 (maxValue = 5)
    final List<double> sampleValues = [3, 2, 4, 5, 3];
    final double maxValue = 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Radar Chart Example'),
      ),
      body: Center(
        child: RadarChart(
          values: sampleValues,
          maxValue: maxValue,
          labels: labels,
          chartSize: 250,
        ),
      ),
    );
  }
}

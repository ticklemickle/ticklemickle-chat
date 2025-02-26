import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/model/radarChartPainter.dart';

class RadarChart extends StatefulWidget {
  /// 예: [자산, 소비, 가능성, 관심, 소득] 순서로 5개의 값
  final List<double> values;

  /// 각 꼭짓점 라벨 (값의 순서와 동일해야 함)
  final List<String>? labels;

  /// values 중 최댓값 (예: 5점 척도, 10점 척도 등)
  final double maxValue;

  /// 차트 크기 지정
  final double chartSize;

  const RadarChart({
    Key? key,
    required this.values,
    required this.maxValue,
    this.labels,
    required this.chartSize,
  }) : super(key: key);

  @override
  _RadarChartState createState() => _RadarChartState();
}

class _RadarChartState extends State<RadarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation; // scale 애니메이션에 사용할 애니메이션

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    // CurvedAnimation을 사용해 자연스러운 확대 효과 적용 (예: easeOutBack)
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 70),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              size: Size(widget.chartSize, widget.chartSize),
              painter: RadarChartPainter(
                values: widget.values,
                maxValue: widget.maxValue,
                labels: widget.labels,
                animationValue: _animation.value, // 0 ~ 1 scale 값 전달
              ),
            );
          },
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

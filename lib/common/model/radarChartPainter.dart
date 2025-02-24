import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:ticklemickle_m/common/themes/colors.dart';

class RadarChartPainter extends CustomPainter {
  final List<double> values;
  final double maxValue;

  /// 꼭짓점 라벨 목록 (values.length와 동일한 개수여야 함)
  final List<String>? labels;

  RadarChartPainter({
    required this.values,
    required this.maxValue,
    this.labels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final n = values.length; // 데이터 개수 (오각형이면 5)
    final angleStep = (2 * math.pi) / n;
    final radius = math.min(size.width / 2, size.height / 2);
    final gridPaint = Paint()
      ..color = MyColors.darkGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final steps = 3; // 5단계로 나눠 그리드 표시
    for (int step = 1; step <= steps; step++) {
      final path = Path();
      final r = radius * (step / steps); // 현재 단계별 반지름
      for (int i = 0; i < n; i++) {
        final angle = angleStep * i - math.pi / 2;
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // (3) 실제 데이터 값으로 그려지는 다각형 및 꼭짓점 좌표 저장
    final dataPath = Path();
    final List<Offset> vertices = []; // 꼭짓점 좌표 저장용 리스트
    for (int i = 0; i < n; i++) {
      final angle = angleStep * i - math.pi / 2;
      final ratio = (values[i] / maxValue).clamp(0, 1); // 값의 비율(0~1)
      final x = center.dx + (radius * ratio) * math.cos(angle);
      final y = center.dy + (radius * ratio) * math.sin(angle);
      final point = Offset(x, y);
      vertices.add(point); // 꼭짓점 저장
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();

// 데이터 영역 채우기
    // final fillPaint = Paint()
    //   ..color = Colors.blue.withOpacity(0.4)
    //   ..style = PaintingStyle.fill;
    // canvas.drawPath(dataPath, fillPaint);

// 데이터 영역 테두리
    final strokePaint = Paint()
      ..color = MyColors.mainDarkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(dataPath, strokePaint);

// (추가) 각 꼭짓점을 강조하기 위한 원형 모양 그리기
    final circlePaint = Paint()
      ..color = MyColors.mainDarkColor
      ..style = PaintingStyle.fill;
    const double vertexCircleRadius = 4.0; // 원의 반지름
    for (final vertex in vertices) {
      canvas.drawCircle(vertex, vertexCircleRadius, circlePaint);
    }

// (4) 각 꼭짓점에 라벨 그리기 (옵션)
    if (labels != null && labels!.length == n) {
      for (int i = 0; i < n; i++) {
        final angle = angleStep * i - math.pi / 2;
        // 라벨을 조금 바깥쪽에 배치하고 싶다면 radius에 여유분(예: +15) 추가
        final labelRadius = radius + 20;
        final labelX = center.dx + labelRadius * math.cos(angle);
        final labelY = center.dy + labelRadius * math.sin(angle);

        final textSpan = TextSpan(
          text: labels![i],
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: size.width,
        );

        // 텍스트 중앙 정렬을 위해 절반 크기만큼 좌표 보정
        final offset = Offset(
          labelX - textPainter.width / 2,
          labelY - textPainter.height / 2,
        );
        textPainter.paint(canvas, offset);
      }
    }
  }

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.labels != labels;
  }
}

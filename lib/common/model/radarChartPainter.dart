import 'package:flutter/material.dart';
import 'dart:math' as math;

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

    // 축 및 그리드선용 페인트
    final axisPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    // (1) 중심에서 각 꼭짓점으로 뻗는 선 그리기
    for (int i = 0; i < n; i++) {
      final angle = angleStep * i - math.pi / 2; // 12시 방향 시작
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), axisPaint);
    }

    // (2) 바깥에서 안쪽으로 겹치는 다각형(그리드) 그리기
    final steps = 5; // 5단계로 나눠 그리드 표시
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
      canvas.drawPath(path, axisPaint);
    }

    // (3) 실제 데이터 값으로 그려지는 다각형
    final dataPath = Path();
    for (int i = 0; i < n; i++) {
      final angle = angleStep * i - math.pi / 2;
      final ratio = (values[i] / maxValue).clamp(0, 1); // 값의 비율(0~1)
      final x = center.dx + (radius * ratio) * math.cos(angle);
      final y = center.dy + (radius * ratio) * math.sin(angle);
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();

    // 데이터 영역 채우기
    final fillPaint = Paint()
      ..color = Colors.blue.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    canvas.drawPath(dataPath, fillPaint);

    // 데이터 영역 테두리
    final strokePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(dataPath, strokePaint);

    // (4) 각 꼭짓점에 라벨 그리기 (옵션)
    if (labels != null && labels!.length == n) {
      for (int i = 0; i < n; i++) {
        final angle = angleStep * i - math.pi / 2;
        // 라벨을 조금 바깥쪽에 배치하고 싶다면 radius에 여유분(예: +15) 추가
        final labelRadius = radius + 15;
        final labelX = center.dx + labelRadius * math.cos(angle);
        final labelY = center.dy + labelRadius * math.sin(angle);

        final textSpan = TextSpan(
          text: labels![i],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
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

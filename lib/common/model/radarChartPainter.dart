import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:ticklemickle_m/common/themes/colors.dart';

class RadarChartPainter extends CustomPainter {
  final List<double> values;
  final double maxValue;
  final double animationValue; // 0 ~ 1 사이의 scale 값
  final List<String>? labels;

  RadarChartPainter({
    required this.values,
    required this.maxValue,
    required this.animationValue,
    this.labels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final n = values.length;
    final angleStep = (2 * math.pi) / n;
    final radius = math.min(size.width / 2, size.height / 2);

    // 1. 그리드 그리기 (애니메이션 영향 없음)
    final gridPaint = Paint()
      ..color = MyColors.darkGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    const int steps = 3;
    for (int step = 1; step <= steps; step++) {
      final path = Path();
      final r = radius * (step / steps);
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

    // 2. 데이터 경로와 꼭짓점 계산 (원본 데이터)
    final dataPath = Path();
    final List<Offset> vertices = [];
    for (int i = 0; i < n; i++) {
      final angle = angleStep * i - math.pi / 2;
      final ratio = (values[i] / maxValue).clamp(0, 1);
      final x = center.dx + (radius * ratio) * math.cos(angle);
      final y = center.dy + (radius * ratio) * math.sin(angle);
      final point = Offset(x, y);
      vertices.add(point);
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();

    // 3. strokePaint와 circlePaint에만 Scale 애니메이션 적용
    //    중심을 기준으로 하는 scale 변환 matrix 생성
    final Matrix4 scaleMatrix = Matrix4.identity();
    scaleMatrix.translate(center.dx, center.dy);
    scaleMatrix.scale(animationValue);
    scaleMatrix.translate(-center.dx, -center.dy);
    final transformedPath = dataPath.transform(scaleMatrix.storage);

    // 애니메이션된 경로 그리기 (strokePaint)
    final strokePaint = Paint()
      ..color = MyColors.mainDarkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(transformedPath, strokePaint);

    // 꼭짓점 원 애니메이션: 각 꼭짓점도 center 기준 scale 적용
    final circlePaint = Paint()
      ..color = MyColors.mainDarkColor
      ..style = PaintingStyle.fill;
    const double finalVertexCircleRadius = 4.0;
    // 원의 반지름도 애니메이션에 따라 변화시키고 싶다면
    final double animatedCircleRadius =
        finalVertexCircleRadius * animationValue;
    for (final vertex in vertices) {
      final scaledVertex = center + (vertex - center) * animationValue;
      canvas.drawCircle(scaledVertex, animatedCircleRadius, circlePaint);
    }

    // 4. 라벨은 원래 위치에 고정해서 그리기 (애니메이션 영향 없음)
    if (labels != null && labels!.length == n) {
      for (int i = 0; i < n; i++) {
        final angle = angleStep * i - math.pi / 2;
        final labelRadius = radius + 20;
        final labelX = center.dx + labelRadius * math.cos(angle);
        final labelY = center.dy + labelRadius * math.sin(angle);

        final textSpan = TextSpan(
          text: labels![i],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(minWidth: 0, maxWidth: size.width);
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
        oldDelegate.labels != labels ||
        oldDelegate.animationValue != animationValue;
  }
}

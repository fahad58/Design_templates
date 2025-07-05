// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math';

class PiChartWidget extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final List<Color>? colors;
  final double size;
  final double labelFontSize;
  final Color labelColor;
  final Widget? titleWidget;
  final Widget? subtitleWidget;
  final double? cardHeight;
  final double? cardWidth;

  const PiChartWidget({
    super.key,
    required this.data,
    required this.labels,
    this.colors,
    this.size = 200,
    this.labelFontSize = 14,
    this.labelColor = Colors.black,
    this.titleWidget,
    this.subtitleWidget,
    this.cardHeight,
    this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    final int itemCount = min(data.length, labels.length);
    final double total = data.fold(0, (sum, item) => sum + item);
    final List<Color> defaultColors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.lime,
      Colors.amber,
      Colors.brown,
    ];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      child: SizedBox(
        height: cardHeight ?? size + 100,
        width: cardWidth ?? size + 100,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (titleWidget != null) titleWidget! else const SizedBox(),
              if (subtitleWidget != null) subtitleWidget! else const SizedBox(),
              SizedBox(
                width: size,
                height: size,
                child: CustomPaint(
                  painter: _PiChartPainter(
                    data: data.sublist(0, itemCount),
                    colors: colors ?? defaultColors,
                    total: total,
                    labels: labels.sublist(0, itemCount),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PiChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;
  final double total;
  final List<String> labels;

  _PiChartPainter({
    required this.data,
    required this.colors,
    required this.total,
    required this.labels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width / 2, size.height / 2);
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    double startAngle = -pi / 2;

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i] / total) * 2 * pi;
      paint.color = colors[i % colors.length];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw percentage text inside the segment
      final double percentage = total == 0 ? 0 : (data[i] / total * 100);
      final double labelAngle = startAngle + sweepAngle / 2;
      final double labelRadius = radius * 0.6;
      final Offset labelPosition = Offset(
        center.dx + labelRadius * cos(labelAngle),
        center.dy + labelRadius * sin(labelAngle),
      );

      final textSpan = TextSpan(
        text: '${percentage.toStringAsFixed(1)}%',
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.black.withOpacity(0.7),
              offset: const Offset(0, 0),
            ),
          ],
        ),
      );

      textPainter.text = textSpan;
      textPainter.layout();
      final offset = labelPosition - Offset(textPainter.width / 2, textPainter.height / 2);
      textPainter.paint(canvas, offset);

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _PiChartPainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.colors != colors || oldDelegate.total != total || oldDelegate.labels != labels;
  }
}

// ..................................................
// PiChartWidget(
//             data: const [10, 20, 30, 40,],
//             labels: const ['Red', 'Green', 'Blue', 'Yellow',],
//             colors: const [Colors.red, Colors.green, Colors.blue, Colors.yellow],
//             size: 250,
//             labelFontSize: 16,
//             labelColor: Colors.black87,
//             titleWidget: const Text(
//               'Sample Pi Chart',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             subtitleWidget: const Text(
//               'Distribution of colors',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),

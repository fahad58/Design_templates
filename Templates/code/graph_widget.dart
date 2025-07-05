import 'package:flutter/material.dart';
import 'dart:math';

class GraphWidget extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final List<Color>? colors;
  final double width;
  final double height;
  final double labelFontSize;
  final Color labelColor;
  final FontWeight labelFontWeight;
  final double barSpacing;
  final Widget? titleWidget;
  final Widget? subtitleWidget;

  const GraphWidget({
    super.key,
    required this.data,
    required this.labels,
    this.colors,
    this.width = 300,
    this.height = 200,
    this.labelFontSize = 14,
    this.labelColor = Colors.black,
    this.labelFontWeight = FontWeight.normal,
    this.barSpacing = 1.0,
    this.titleWidget,
    this.subtitleWidget,
  });

  @override
  Widget build(BuildContext context) {
    final int itemCount = min(data.length, labels.length);
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

    final double maxData = data.isEmpty ? 0 : data.reduce(max);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      child: SizedBox(
        width: width + 60,
        height: height + 100,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (titleWidget != null) titleWidget! else const SizedBox(),
              if (subtitleWidget != null) subtitleWidget! else const SizedBox(),
              SizedBox(
                width: width,
                height: height,
                child: CustomPaint(
                  painter: _GraphPainter(
                    data: data.sublist(0, itemCount),
                    colors: colors ?? defaultColors,
                    labels: labels.sublist(0, itemCount),
                    maxData: maxData,
                    labelFontSize: labelFontSize,
                    labelColor: labelColor,
                    labelFontWeight: labelFontWeight,
                    barSpacing: barSpacing,
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

class _GraphPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;
  final List<String> labels;
  final double maxData;
  final double labelFontSize;
  final Color labelColor;
  final FontWeight labelFontWeight;
  final double barSpacing;

  _GraphPainter({
    required this.data,
    required this.colors,
    required this.labels,
    required this.maxData,
    required this.labelFontSize,
    required this.labelColor,
    required this.labelFontWeight,
    required this.barSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint barPaint = Paint()..style = PaintingStyle.fill;
    final double barWidth = size.width / (data.length * (barSpacing + 1));
    final double maxBarHeight = size.height * 0.7;
    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Draw bars
    for (int i = 0; i < data.length; i++) {
      final double normalizedHeight = maxData == 0 ? 0 : (data[i] / maxData) * maxBarHeight;
      final double x = barWidth * barSpacing / 2 + i * barWidth * (barSpacing + 1);
      final double y = size.height - normalizedHeight;

      barPaint.color = colors[i % colors.length];
      final Rect barRect = Rect.fromLTWH(x, y, barWidth, normalizedHeight);
      canvas.drawRect(barRect, barPaint);

      // Draw value above bar
      final textSpan = TextSpan(
        text: data[i].toStringAsFixed(1),
        style: TextStyle(
          fontSize: labelFontSize * 0.8,
          color: labelColor,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.text = textSpan;
      textPainter.layout();
      final offset = Offset(x + barWidth / 2 - textPainter.width / 2, y - textPainter.height - 2);
      textPainter.paint(canvas, offset);

      // Draw label below bar
      final labelSpan = TextSpan(
        text: labels[i],
        style: TextStyle(
          fontSize: labelFontSize,
          color: labelColor,
          fontWeight: labelFontWeight,
        ),
      );
      textPainter.text = labelSpan;
      textPainter.layout(maxWidth: barWidth * (barSpacing + 1));
      final labelOffset = Offset(x + barWidth / 2 - textPainter.width / 2, size.height + 4);
      textPainter.paint(canvas, labelOffset);
    }
  }

  @override
  bool shouldRepaint(covariant _GraphPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.colors != colors ||
        oldDelegate.labels != labels ||
        oldDelegate.maxData != maxData ||
        oldDelegate.labelFontSize != labelFontSize ||
        oldDelegate.labelColor != labelColor ||
        oldDelegate.labelFontWeight != labelFontWeight ||
        oldDelegate.barSpacing != barSpacing;
  }
}
// ................................................
// GraphWidget(
//             data: const [10, 25, 15, 30, 20],
//             labels: const ['A', 'B', 'C', 'D', 'E'],
//             colors: const [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple],
//             titleWidget: const Text(
//               'Sample Graph Chart',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             subtitleWidget: const Text(
//               'Data distribution',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             width: 350,
//             height: 250,
//             labelFontSize: 14,
//             labelColor: Colors.black87,
//             labelFontWeight: FontWeight.w600,
//             barSpacing: 1.5,
//           ),

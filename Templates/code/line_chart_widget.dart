import 'package:flutter/material.dart';
import 'dart:math';

class LineChartWidget extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final List<Color>? colors;
  final double width;
  final double height;
  final double labelFontSize;
  final Color labelColor;
  final FontWeight labelFontWeight;
  final double pointSpacing;
  final Widget? titleWidget;
  final Widget? subtitleWidget;

  const LineChartWidget({
    super.key,
    required this.data,
    required this.labels,
    this.colors,
    this.width = 300,
    this.height = 200,
    this.labelFontSize = 14,
    this.labelColor = Colors.black,
    this.labelFontWeight = FontWeight.normal,
    this.pointSpacing = 1.0,
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
                  painter: _LineChartPainter(
                    data: data.sublist(0, itemCount),
                    colors: colors ?? defaultColors,
                    labels: labels.sublist(0, itemCount),
                    maxData: maxData,
                    labelFontSize: labelFontSize,
                    labelColor: labelColor,
                    labelFontWeight: labelFontWeight,
                    pointSpacing: pointSpacing,
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

class _LineChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;
  final List<String> labels;
  final double maxData;
  final double labelFontSize;
  final Color labelColor;
  final FontWeight labelFontWeight;
  final double pointSpacing;

  _LineChartPainter({
    required this.data,
    required this.colors,
    required this.labels,
    required this.maxData,
    required this.labelFontSize,
    required this.labelColor,
    required this.labelFontWeight,
    required this.pointSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final Paint pointPaint = Paint()..style = PaintingStyle.fill;

    final double maxLineHeight = size.height * 0.7;
    final double spacing = size.width / (data.length * (pointSpacing + 1));
    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final List<Offset> points = [];

    for (int i = 0; i < data.length; i++) {
      final double normalizedHeight = maxData == 0 ? 0 : (data[i] / maxData) * maxLineHeight;
      final double x = spacing * pointSpacing / 2 + i * spacing * (pointSpacing + 1);
      final double y = size.height - normalizedHeight;
      points.add(Offset(x, y));
    }

    // Draw lines connecting points
    for (int i = 0; i < points.length - 1; i++) {
      linePaint.color = colors[i % colors.length];
      canvas.drawLine(points[i], points[i + 1], linePaint);
    }

    // Draw points and labels
    for (int i = 0; i < points.length; i++) {
      pointPaint.color = colors[i % colors.length];
      canvas.drawCircle(points[i], 6, pointPaint);

      // Draw value above point
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
      final offset = Offset(points[i].dx - textPainter.width / 2, points[i].dy - textPainter.height - 8);
      textPainter.paint(canvas, offset);

      // Draw label below point
      final labelSpan = TextSpan(
        text: labels[i],
        style: TextStyle(
          fontSize: labelFontSize,
          color: labelColor,
          fontWeight: labelFontWeight,
        ),
      );
      textPainter.text = labelSpan;
      textPainter.layout(maxWidth: spacing * (pointSpacing + 1));
      final labelOffset = Offset(points[i].dx - textPainter.width / 2, size.height + 4);
      textPainter.paint(canvas, labelOffset);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.colors != colors ||
        oldDelegate.labels != labels ||
        oldDelegate.maxData != maxData ||
        oldDelegate.labelFontSize != labelFontSize ||
        oldDelegate.labelColor != labelColor ||
        oldDelegate.labelFontWeight != labelFontWeight ||
        oldDelegate.pointSpacing != pointSpacing;
  }
}
// ..........................................
// LineChartWidget(
//                 data: const [5, 15, 10, 20, 25],
//                 labels: const ['W', 'X', 'Y', 'Z', 'Q'],
//                 colors: const [Colors.blue, Colors.orange, Colors.green, Colors.red, Colors.purple],
//                 titleWidget: const Text(
//                   'Sample Line Chart',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 subtitleWidget: const Text(
//                   'Line data distribution',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 width: 350,
//                 height: 250,
//                 labelFontSize: 14,
//                 labelColor: Colors.black87,
//                 labelFontWeight: FontWeight.w600,
//                 pointSpacing: 1.5,
//               ),

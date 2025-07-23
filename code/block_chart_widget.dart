// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'dart:math';

class BlocksChartWidget extends StatelessWidget {
  final List<double> data;
  final List<String> labels;

  final Color barColor;
  final List<Color>? barColors;
  final Color labelColor;
  final double labelFontSize;

  final double maxBarHeight;
  final Color backgroundColor;

  final Color cardColor;

  final double baseHeight;
  final double labelHeight;

  final double barWidth;
  final double barSpacing;
  final double yAxisWidth;

  final int barsToFit;

  final String fontFamily;
  final FontWeight fontWeight;

  final Widget? titleWidget;
  final Widget? subtitleWidget;

  final bool indexValue;

  final double? width;
  final double? height;

  const BlocksChartWidget({
    super.key,
    required this.data,
    required this.labels,
    required this.barColor,
    this.barColors,
    required this.labelColor,
    required this.labelFontSize,
    required this.maxBarHeight,
    required this.backgroundColor,
    required this.baseHeight,
    required this.labelHeight,
    required this.barWidth,
    required this.barSpacing,
    required this.yAxisWidth,
    required this.fontFamily,
    required this.fontWeight,
    this.titleWidget,
    this.subtitleWidget,
    required this.indexValue,
    this.width,
    this.height,
    this.barsToFit = 7,
    this.cardColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final int itemCount = min(data.length, labels.length);
    final double maxValue = data.isNotEmpty ? data.reduce(max) : 1;
    final ScrollController scrollController = ScrollController();

    Widget cardContent = Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double widthScale = width != null ? (width! / 400) : 1;
            final double heightScale = height != null ? (height! / 300) : 1;

            // Base dimensions as per original design
            final double baseMaxBarHeight = maxBarHeight;
            final double baseBaseHeight = baseHeight;
            final double baseLabelHeight = labelHeight;
            final double baseBarWidth = barWidth;
            final double baseBarSpacing = barSpacing;
            final double baseYAxisWidth = yAxisWidth;
            final double baseLabelFontSize = labelFontSize;

            // Scaled dimensions
            final double scaledMaxBarHeight = baseMaxBarHeight * heightScale;
            final double scaledBaseHeight = baseBaseHeight * heightScale;
            final double scaledLabelHeight = baseLabelHeight * heightScale;
            final double scaledBarWidth = baseBarWidth * widthScale;
            final double scaledBarSpacing = baseBarSpacing * widthScale;
            final double scaledYAxisWidth = baseYAxisWidth * widthScale;
            final double scaledLabelFontSize = baseLabelFontSize * widthScale;

            final double scaleFactor = maxValue > 0 ? scaledMaxBarHeight / maxValue : 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (titleWidget != null) titleWidget! else const SizedBox(),
                SizedBox(height: scaledLabelHeight / 3),
                if (subtitleWidget != null) subtitleWidget! else const SizedBox(),
                SizedBox(height: scaledBaseHeight / 3),

                SizedBox(
                  height: scaledMaxBarHeight + scaledLabelHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: scaledYAxisWidth,
                        height: scaledMaxBarHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(4, (index) {
                            final int value = (maxValue / 3 * (3 - index)).round();
                            return Text(
                              '$value',
                              style: TextStyle(
                                color: labelColor,
                                fontSize: scaledLabelFontSize,
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(width: scaledBarSpacing / 2),

                      Expanded(
                        child: Scrollbar(
                          controller: scrollController,
                          thumbVisibility: true,
                          radius: const Radius.circular(4),
                          thickness: 6,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final double availableWidth = constraints.maxWidth;
                              final int barsToFitLocal = barsToFit > 0 ? barsToFit : 7;
                              final double barSpacingScaled = scaledBarSpacing;
                              final double barWidthScaled =
                                  (availableWidth - (barSpacingScaled * (barsToFitLocal - 1))) / barsToFitLocal;

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: scrollController,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: List.generate(itemCount, (index) {
                                    final double barHeight = data[index] * scaleFactor;
                                    return Container(
                                      margin: EdgeInsets.only(right: barSpacingScaled),
                                      width: barWidthScaled,
                                      child: SizedBox(
                                        height: scaledMaxBarHeight + scaledLabelHeight,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: barHeight,
                                              width: barWidthScaled,
                                              decoration: BoxDecoration(
                                                color: (barColors != null && index < barColors!.length)
                                                    ? barColors![index]
                                                    : barColor,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                            SizedBox(height: scaledLabelHeight / 6),
                                            SizedBox(
                                              height: scaledLabelHeight * 0.8,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  labels[index],
                                                  style: TextStyle(
                                                    color: labelColor,
                                                    fontSize: scaledLabelFontSize,
                                                    fontFamily: fontFamily,
                                                    fontWeight: fontWeight,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: cardContent,
      );
    } else {
      return cardContent;
    }
  }
}
// ..................................................
// Dummy Data:
// BlocksChartWidget(
//           data: [10, 25, 15, 35, 60, 20, 30, 22, 18, 40, 50, 80, 55],
//           labels: [
//             'label1',
//             'label2',
//             'label3',
//             'label4',
//             'label5',
//             'label6',
//             'label7',
//             'label8',
//             'label9',
//             'label10',
//             'label11',
//             'label12',
//             'label13'
//           ],
//           backgroundColor: const Color.fromARGB(255, 12, 12, 12),
//           cardColor: Colors.white,
//           width: 400,
//           height: 300,
//           barColor: Colors.orange,
//           barColors: [
//             Colors.red,
//             Colors.orange,
//             Colors.yellow,
//             Colors.green,
//             Colors.blue,
//             Colors.indigo,
//             Colors.purple,
//             Colors.pink,
//             Colors.teal,
//             Colors.cyan,
//             Colors.lime,
//             Colors.amber,
//             Colors.brown,
//           ],
//           labelColor: const Color.fromARGB(255, 10, 10, 10),
//           labelFontSize: 14,
//           maxBarHeight: 150,
//           baseHeight: 50,
//           labelHeight: 25,
//           barWidth: 30,
//           barSpacing: 20,
//           yAxisWidth: 50,
//           fontFamily: 'Arial',
//           fontWeight: FontWeight.w600,
//           titleWidget: Text(
//             'Statistics',
//             style: TextStyle(
//               color: Colors.lightBlue,
//               fontSize: 14,
//               fontFamily: 'Arial',
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           subtitleWidget: Text(
//             'Monthly spending',
//             style: TextStyle(
//               color: const Color.fromARGB(255, 5, 5, 5),
//               fontSize: 20,
//               fontFamily: 'Arial',
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           indexValue: true,
//         ),

import 'package:flutter/material.dart';

class GridWidget extends StatelessWidget {
  final Widget child;
  final bool showCard;
  final double? cardHeight;
  final double? cardWidth;
  final EdgeInsetsGeometry? cardMargin;
  final EdgeInsetsGeometry? cardPadding;
  final Color? cardColor;
  final double? cardElevation;
  final BorderRadiusGeometry? cardBorderRadius;
  final AlignmentGeometry? cardAlignment;

  const GridWidget({
    super.key,
    required this.child,
    this.showCard = true,
    this.cardHeight,
    this.cardWidth,
    this.cardMargin,
    this.cardPadding,
    this.cardColor = Colors.white,
    this.cardElevation = 4,
    this.cardBorderRadius,
    this.cardAlignment,
  });

  @override
  Widget build(BuildContext context) {
    Widget grid = GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [child],
    );

    Widget content = Container(
      margin: cardMargin ?? EdgeInsets.zero,
      padding: cardPadding ?? const EdgeInsets.all(8),
      child: grid,
    );

    if (showCard) {
      return Align(
        alignment: cardAlignment ?? Alignment.center,
        child: Card(
          elevation: cardElevation,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: cardBorderRadius ?? BorderRadius.circular(16),
          ),
          child: content,
        ),
      );
    } else {
      return Align(
        alignment: cardAlignment ?? Alignment.center,
        child: content,
      );
    }
  }
}

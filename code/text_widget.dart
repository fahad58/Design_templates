import 'package:flutter/material.dart';

enum TextPosition {
  topLeft,
  topRight,
  topCenter,
  bottomLeft,
  bottomRight,
  bottomCenter,
  center,
}

class CustomTextWidget extends StatelessWidget {
  final Widget title;
  final Widget? description;
  final TextPosition titlePosition;
  final TextPosition descriptionPosition;
  final bool showCard;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? cardColor;
  final double? cardElevation;
  final BorderRadiusGeometry? cardBorderRadius;
  final AlignmentGeometry? alignment;

  const CustomTextWidget({
    super.key,
    required this.title,
    this.description,
    this.titlePosition = TextPosition.topLeft,
    this.descriptionPosition = TextPosition.bottomLeft,
    this.showCard = true,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.cardColor = Colors.white,
    this.cardElevation = 4,
    this.cardBorderRadius,
    this.alignment,
  });

  Widget _buildPositionedWidget(Widget widget, TextPosition position) {
    switch (position) {
      case TextPosition.topLeft:
        return Align(alignment: Alignment.topLeft, child: widget);
      case TextPosition.topRight:
        return Align(alignment: Alignment.topRight, child: widget);
      case TextPosition.topCenter:
        return Align(alignment: Alignment.topCenter, child: widget);
      case TextPosition.bottomLeft:
        return Align(alignment: Alignment.bottomLeft, child: widget);
      case TextPosition.bottomRight:
        return Align(alignment: Alignment.bottomRight, child: widget);
      case TextPosition.bottomCenter:
        return Align(alignment: Alignment.bottomCenter, child: widget);
      case TextPosition.center:
        return Align(alignment: Alignment.center, child: widget);
      }
  }

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = DefaultTextStyle.merge(
      style: const TextStyle(fontFamily: 'Roboto'),
      child: _buildPositionedWidget(title, titlePosition),
    );

    Widget descriptionWidget = description != null
        ? Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DefaultTextStyle.merge(
              style: const TextStyle(fontFamily: 'Roboto'),
              child: _buildPositionedWidget(description!, descriptionPosition),
            ),
          )
        : const SizedBox.shrink();

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget,
        descriptionWidget,
      ],
    );

    if (showCard) {
      return Align(
        alignment: alignment ?? Alignment.center,
        child: Card(
          elevation: cardElevation,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: cardBorderRadius ?? BorderRadius.circular(16),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: Container(
              margin: margin ?? EdgeInsets.zero,
              width: width,
              height: height,
              child: content,
            ),
          ),
        ),
      );
    } else {
          return Align(
            alignment: alignment ?? Alignment.center,
            child: Container(
              margin: margin ?? EdgeInsets.zero,
              width: width,
              height: height,
              padding: padding ?? const EdgeInsets.all(0),
              child: content,
            ),
          );
    }
  }
}

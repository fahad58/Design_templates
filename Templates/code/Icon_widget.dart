import 'package:flutter/material.dart';

enum IconPosition { top, left, right }

// ignore: camel_case_types
class icon_widget_box extends StatelessWidget {
  final Widget title;
  final Widget? description;
  final Widget? icon;
  final IconPosition iconPosition;
  final Widget? button;

  final double? cardWidth;
  final EdgeInsetsGeometry? cardMargin;
  final AlignmentGeometry? cardAlignment;

  // Card container customization
  final double? cardElevation;
  final Color? cardColor;
  final BorderRadiusGeometry? cardBorderRadius;
  final EdgeInsetsGeometry? cardPadding;

  const icon_widget_box({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.iconPosition = IconPosition.top,
    this.button,
    this.cardWidth,
    this.cardMargin,
    this.cardAlignment,
    this.cardElevation = 4,
    this.cardColor = Colors.white,
    this.cardBorderRadius,
    this.cardPadding,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle.merge(
          style: const TextStyle(fontFamily: 'Roboto'),
          child: title,
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          DefaultTextStyle.merge(
            style: const TextStyle(fontFamily: 'Roboto'),
            child: description!,
          ),
        ],
        if (button != null) ...[
          const SizedBox(height: 20),
          button!,
        ],
      ],
    );

    Widget cardChild;
    if (icon != null) {
      switch (iconPosition) {
        case IconPosition.left:
          cardChild = Row(
            children: [
              icon!,
              const SizedBox(width: 16),
              Expanded(child: content),
            ],
          );
          break;
        case IconPosition.right:
          cardChild = Row(
            children: [
              Expanded(child: content),
              const SizedBox(width: 16),
              icon!,
            ],
          );
          break;
        case IconPosition.top:
        // ignore: unreachable_switch_default
        default:
          cardChild = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon!,
              const SizedBox(height: 16),
              content,
            ],
          );
      }
    } else {
      cardChild = content;
    }

    return Align(
      alignment: cardAlignment ?? Alignment.center,
      child: Card(
        elevation: cardElevation,
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: cardBorderRadius ?? BorderRadius.circular(16),
        ),
        child: Padding(
          padding: cardPadding ?? const EdgeInsets.all(16),
          child: Container(
            margin: cardMargin ?? EdgeInsets.zero,
            width: cardWidth ?? 400,
            child: cardChild,
          ),
        ),
      ),
    );
  }
}

.............................................................................
  $$$$$ DUMMY DATA MAIN.DART WHICH YOU CAN COUSTOMIZE ACCORDING TO YOU $$$$$
// icon_widget_box card customization example:
                icon_widget_box(
                  title: const Text(
                    'Winter Blazer',
                    style: TextStyle(
                      //  fontStyle: FontStyle.italic,
                      fontSize: 18,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  description: const Text(
                    'Anything you want to write here',
                    style: TextStyle(
                      // fontFamily: 'Roboto',
                      fontSize: 18,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  icon: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Color.fromARGB(255, 170, 41, 41),
                      size: 20,
                    ),
                  ),
                  cardWidth: 350,
                  cardMargin: const EdgeInsets.all(20),
                  cardAlignment: Alignment.center,
                ),

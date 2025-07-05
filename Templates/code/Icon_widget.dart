import 'package:flutter/material.dart';

enum IconPosition { top, left, right }

class IconWidgetBox extends StatelessWidget {
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

  // New optional layout customizations
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  final double? iconSpacing;
  final double? iconSize;

  const IconWidgetBox({
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
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.iconSpacing,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveIconSpacing = iconSpacing ?? 16.0;

    Widget content = Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
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

    Widget? resizedIcon = icon != null && iconSize != null
        ? SizedBox(
            height: iconSize,
            width: iconSize,
            child: icon,
          )
        : icon;

    Widget cardChild;
    if (resizedIcon != null) {
      switch (iconPosition) {
        case IconPosition.left:
          cardChild = Row(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              resizedIcon,
              SizedBox(width: effectiveIconSpacing),
              Expanded(child: content),
            ],
          );
          break;
        case IconPosition.right:
          cardChild = Row(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              Expanded(child: content),
              SizedBox(width: effectiveIconSpacing),
              resizedIcon,
            ],
          );
          break;
        case IconPosition.top:
          cardChild = Column(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              resizedIcon,
              SizedBox(height: effectiveIconSpacing),
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
            width: cardWidth ?? double.infinity,
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
                    'Meditation Reminder',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.0,
                    ),
                  ),
                  description: const Text(
                    'Set a daily reminder to meditate and improve your mental well-being.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                          color:  const Color(0xFFD8F5E1), // soft green background
                          borderRadius: BorderRadius.circular(8), // rounded square
                          ),
                    
                    child: const Icon(
                        Icons.favorite_border,
                        color: Color(0xFF2AA972), // green stroke color
                        size: 20,
                      ),
                      
                      
                    ),
                  
                  cardWidth: 350,
                  cardMargin: const EdgeInsets.all(20),
                  cardAlignment: Alignment.center,
                ),

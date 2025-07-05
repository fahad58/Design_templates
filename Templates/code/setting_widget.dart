// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  final String label;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? textColor;

  final IconData iconData;
  final double? iconSize;
  final Color? iconColor;
  final bool iconCircular;
  final Color? iconBackgroundColor;

  final double? cardHeight;
  final double? cardWidth;
  final Color? cardColor;
  final BoxBorder? cardBorder;

  final VoidCallback? onTap;

  const SettingsWidget({
    super.key,
    required this.label,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.textColor,
    required this.iconData,
    this.iconSize,
    this.iconColor,
    this.iconCircular = true,
    this.iconBackgroundColor,
    this.cardHeight,
    this.cardWidth,
    this.cardColor,
    this.cardBorder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveCardColor = cardColor ?? Theme.of(context).inputDecorationTheme.fillColor ?? Colors.grey[800]!;
    final Color effectiveIconBackgroundColor = iconBackgroundColor ?? Theme.of(context).cardColor.withOpacity(0.1);
    final Color effectiveIconColor = iconColor ?? Theme.of(context).colorScheme.secondary;
    final Color effectiveTextColor = textColor ?? Theme.of(context).colorScheme.secondary;

    final BoxBorder effectiveCardBorder = cardBorder ?? Border.all(color: Colors.black);

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: cardHeight,
        width: cardWidth ?? double.infinity,
        decoration: BoxDecoration(
          color: effectiveCardColor,
          borderRadius: BorderRadius.circular(12),
          border: effectiveCardBorder,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 16, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: iconCircular ? 48 : iconSize ?? 24,
                height: iconCircular ? 48 : iconSize ?? 24,
                decoration: BoxDecoration(
                  color: iconCircular ? effectiveIconBackgroundColor : Colors.transparent,
                  shape: iconCircular ? BoxShape.circle : BoxShape.rectangle,
                ),
                alignment: AlignmentDirectional.center,
                child: Icon(
                  iconData,
                  size: iconSize ?? 24,
                  color: effectiveIconColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize ?? 17,
                    fontFamily: fontFamily,
                    fontWeight: fontWeight ?? FontWeight.normal,
                    color: effectiveTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: effectiveIconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ................................................

// SettingsWidget(
//             label: 'User Profile',
//             fontSize: 18,
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.bold,
//             textColor: Colors.blueAccent,
//             iconData: Icons.account_circle,
//             iconSize: 30,
//             iconColor: const Color.fromARGB(255, 10, 10, 10),
//             iconCircular: true,
//             cardBorder: Border.all(color: Colors.black),
//             cardHeight: 60,
//             cardWidth: double.infinity,
//             cardColor: const Color.fromARGB(255, 240, 239, 239),
//             onTap: () {
//               print('Settings tapped');
//             },
//           ),

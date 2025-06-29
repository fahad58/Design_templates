import 'package:flutter/material.dart';

class ImageCardWidget extends StatelessWidget {
  final Widget image;
  final Widget title;
  final Widget text;
  final Widget? icon;

  final double? imageHeight;
  final double? imageWidth;

  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final AlignmentGeometry? alignment;

  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final double? titleSpacing;
  final double? contentSpacing;

  // Card container customization
  final double? cardElevation;
  final Color? cardColor;
  final BorderRadiusGeometry? cardBorderRadius;
  final EdgeInsetsGeometry? cardMargin;
  final EdgeInsetsGeometry? cardPadding;

  const ImageCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.text,
    this.icon,
    this.imageHeight,
    this.imageWidth,
    this.width,
    this.margin,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.boxShadow,
    this.alignment,
    this.titleStyle,
    this.textStyle,
    this.titleSpacing,
    this.contentSpacing,
    this.cardElevation = 4,
    this.cardColor = Colors.white,
    this.cardBorderRadius,
    this.cardMargin,
    this.cardPadding,
  });

  @override
  Widget build(BuildContext context) {
    final double spacingAboveTitle = titleSpacing ?? 8.0;
    final double spacingBelowTitle = contentSpacing ?? 8.0;

    return Container(
      width: width ?? double.infinity,
      margin: cardMargin ?? margin,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: boxShadow,
        color: backgroundColor,
      ),
      child: Card(
        elevation: cardElevation,
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: cardBorderRadius ?? BorderRadius.circular(16),
        ),
        child: Padding(
          padding: cardPadding ?? padding ?? const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.circular(16),
                child: SizedBox(
                  height: imageHeight,
                  width: imageWidth ?? double.infinity,
                  child: image,
                ),
              ),
              SizedBox(height: spacingAboveTitle),
              DefaultTextStyle.merge(
                style: titleStyle ?? const TextStyle(fontFamily: 'Roboto', fontSize: 18, fontWeight: FontWeight.bold),
                child: title,
              ),
              SizedBox(height: spacingBelowTitle),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DefaultTextStyle.merge(
                      style: textStyle ?? const TextStyle(fontFamily: 'Roboto', fontSize: 14),
                      child: text,
                    ),
                  ),
                  if (icon != null) icon!,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


..................................................................
$$$$$ DUMMY DATA $$$$$
 ImageWidget(
                  width: 350,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(16),
                  backgroundColor: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                  alignment: Alignment.center,
                  image: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/cate--1.png',
                      width: double.infinity,
                      height: 117,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Text(
                    'Winter Blazer',
                    style: TextStyle(
                      // fontStyle: FontStyle.italic,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  price: const Text(
                    'Anything you want to write here',
                    style: TextStyle(
                     fontStyle: FontStyle.italic,
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
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Color.fromARGB(255, 170, 41, 41),
                      size: 20,
                    ),
                  ),
                ),

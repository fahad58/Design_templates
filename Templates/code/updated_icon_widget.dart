import 'package:flutter/material.dart';


enum IconPosition {
  top,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  center,
}

enum TitlePosition {
  topLeft,
  topRight,
  topCenter,
  bottomLeft,
  bottomRight,
  bottomCenter,
  center,
}

enum DescriptionPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  center,
}

// ignore: camel_case_types
class icon_widget_box extends StatelessWidget {
  final Widget? title;
  final Widget? description;
  final Widget? icon;
  final List<Map<String, Widget>>? iconLabelPairs;

  final IconPosition iconPosition;
  final TitlePosition titlePosition;
  final DescriptionPosition descriptionPosition;
  final Widget? button;
  final Widget? customChild;

  final double? cardWidth;
  final double? cardHeight;
  final EdgeInsetsGeometry? cardMargin;
  final AlignmentGeometry? cardAlignment;

  // Card container customization
  final double? cardElevation;
  final Color? cardColor;
  final BorderRadiusGeometry? cardBorderRadius;
  final EdgeInsetsGeometry? cardPadding;

  final bool showCard;
  final bool titleUnderIcon;
  final bool iconInFrontOfTitleUnderDescription;

  const icon_widget_box({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.iconLabelPairs,
    this.iconPosition = IconPosition.left,
    this.titlePosition = TitlePosition.topLeft,
    this.descriptionPosition = DescriptionPosition.bottomLeft,
    this.button,
    this.customChild,
    this.cardWidth,
    this.cardHeight,
    this.cardMargin,
    this.cardAlignment,
    this.cardElevation = 4,
    this.cardColor = Colors.white,
    this.cardBorderRadius,
    this.cardPadding,
    this.showCard = true,
    this.titleUnderIcon = false,
    this.iconInFrontOfTitleUnderDescription = false,
  });

  // ignore: unused_element
  Widget _buildPositionedWidget(Widget widget, dynamic position) {
    switch (position) {
      case TitlePosition.topLeft:
      case DescriptionPosition.topLeft:
        return Align(alignment: Alignment.topLeft, child: widget);
      case TitlePosition.topRight:
      case DescriptionPosition.topRight:
        return Align(alignment: Alignment.topRight, child: widget);
      case TitlePosition.topCenter:
        return Align(alignment: Alignment.topCenter, child: widget);
      case TitlePosition.bottomLeft:
      case DescriptionPosition.bottomLeft:
        return Align(alignment: Alignment.bottomLeft, child: widget);
      case TitlePosition.bottomRight:
      case DescriptionPosition.bottomRight:
        return Align(alignment: Alignment.bottomRight, child: widget);
      case TitlePosition.bottomCenter:
        return Align(alignment: Alignment.bottomCenter, child: widget);
      case TitlePosition.center:
      case DescriptionPosition.center:
        return Align(alignment: Alignment.center, child: widget);
      default:
        return widget;
    }
  }

  Widget _buildIconsWidget() {
    if (iconLabelPairs == null || iconLabelPairs!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: iconLabelPairs!.map((pair) {
        final icon = pair['icon']!;
        final label = pair['label'];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            if (label != null) ...[
              const SizedBox(height: 4),
              label,
            ],
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (customChild != null) {
      Widget content = Container(
        margin: cardMargin ?? EdgeInsets.zero,
        width: cardWidth,
        height: cardHeight,
        child: customChild,
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
            child: Padding(
              padding: cardPadding ?? const EdgeInsets.all(16),
              child: content,
            ),
          ),
        );
      } else {
        return Align(
          alignment: cardAlignment ?? Alignment.center,
          child: Container(
            color: Colors.transparent,
            child: content,
          ),
        );
      }
    }

    Widget titleWidget;
    if (title == null) {
      titleWidget = const SizedBox.shrink();
    } else {
      titleWidget = DefaultTextStyle.merge(
        style: const TextStyle(fontFamily: 'Roboto'),
        child: title!,
      );
    }

    Widget descriptionWidget = description != null
        ? DefaultTextStyle.merge(
            style: const TextStyle(fontFamily: 'Roboto'),
            child: description!,
          )
        : const SizedBox.shrink();

    Widget buttonWidget = button != null
        ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: button!,
          )
        : const SizedBox.shrink();

    Widget descriptionRow;
    if (icon != null && iconPosition == IconPosition.bottomRight) {
      descriptionRow = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: descriptionWidget),
          const SizedBox(width: 8),
          icon!,
        ],
      );
    } else {
      descriptionRow = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: descriptionWidget),
        ],
      );
    }

    List<Widget> children = [];

    if (iconLabelPairs != null && iconLabelPairs!.isNotEmpty) {
      children.add(_buildIconsWidget());
      children.add(const SizedBox(height: 16));
    }

    if (icon != null && iconPosition != IconPosition.bottomRight) {
      if (iconInFrontOfTitleUnderDescription) {
        children.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon!,
                const SizedBox(width: 8),
                titleWidget,
              ],
            ),
            const SizedBox(height: 8),
            descriptionWidget,
            const SizedBox(height: 8),
            icon!,
          ],
        ));
      } else if (titleUnderIcon) {
        children.add(Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon!,
            const SizedBox(height: 8),
            titleWidget,
          ],
        ));
      } else {
        children.add(Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon!,
            const SizedBox(width: 8),
            titleWidget,
          ],
        ));
      }
    } else {
      children.add(titleWidget);
    }
    children.add(const SizedBox(height: 8));
    children.add(descriptionRow);
    children.add(buttonWidget);

    Widget contentColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );

    if (!showCard) {
      return Align(
        alignment: cardAlignment ?? Alignment.center,
        child: Container(
          margin: cardMargin ?? EdgeInsets.zero,
          width: cardWidth ?? 400,
          height: cardHeight,
          padding: cardPadding ?? const EdgeInsets.all(16),
          color: Colors.transparent,
          child: contentColumn,
        ),
      );
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
              width: cardWidth,
              height: cardHeight,
              child: contentColumn,
            ),
        ),
      ),
    );
  }
}

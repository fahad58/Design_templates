import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool autofocus;
  final bool autocorrect;
  final TextInputAction? textInputAction;
  final String? labelText;
  final TextStyle? labelStyle;

  final BorderRadius? borderRadius;

 
  final IconData? icon;
  final bool isIconPrefix;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.validator,
    this.onChanged,
    this.decoration,
    this.style,
    this.autofocus = false,
    this.autocorrect = true,
    this.textInputAction,
    this.labelText,
    this.labelStyle,
    this.borderRadius,
    this.icon,
    this.isIconPrefix = true, // default to prefix icon
  });

  @override
  Widget build(BuildContext context) {
    final InputDecoration effectiveDecoration = (decoration ?? const InputDecoration()).copyWith(
      labelText: labelText,
      labelStyle: labelStyle,
      border: OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      prefixIcon: isIconPrefix && icon != null ? Icon(icon) : null,
      suffixIcon: !isIconPrefix && icon != null ? Icon(icon) : null,
    );

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      autocorrect: autocorrect,
      textInputAction: textInputAction ?? TextInputAction.search,
      onChanged: onChanged,
      validator: validator,
      decoration: effectiveDecoration,
      style: style,
    );
  }
}
.....................................................
  $$$$$$ DUMMY DATA $$$$$$$$
   SearchBarWidget(
  controller: _controller2,
  focusNode: _focusNode2,
  labelText: 'Search Homes',
  labelStyle: const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 2, 11, 19),
  ),
  borderRadius: BorderRadius.circular(12),
  icon: Icons.home, 
)

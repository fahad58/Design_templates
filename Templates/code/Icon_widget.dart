// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  // New customizable parameters with defaults
  final String hintText;
  final TextStyle? hintStyle;
  final Color fillColor;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final BorderRadius borderRadius;

  // New callback for custom functionality
  final ValueChanged<String>? onChanged;

  // Optional validator, default provided internally
  final String? Function(String?)? validator;

  const SearchBarWidget({
    super.key,
    this.validator,
    this.hintText = 'Search',
    this.hintStyle,
    this.fillColor = const Color(0xFFE0E0E0), // Colors.grey.shade200
    this.prefixIcon,
    this.textStyle,
    BorderRadius? borderRadius,
    this.onChanged,
  }) : borderRadius = borderRadius ?? const BorderRadius.all(Radius.circular(100));

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _searchTextController;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a search term';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: _searchTextController,
        focusNode: _searchFocusNode,
        autofocus: false,
        obscureText: false,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ?? const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
            borderRadius: widget.borderRadius,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
            borderRadius: widget.borderRadius,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
            borderRadius: widget.borderRadius,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
            borderRadius: widget.borderRadius,
          ),
          filled: true,
          fillColor: widget.fillColor,
          prefixIcon: widget.prefixIcon ?? const Icon(
            Icons.search_sharp,
            color: Colors.grey,
          ),
        ),
        style: widget.textStyle ?? const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontFamily: 'Roboto',
        ),
        validator: widget.validator ?? _defaultValidator,
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

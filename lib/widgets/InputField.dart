import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController? controller;
  final bool enabled;
  final bool readOnly;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final String? suffixText;
  final String? helperText;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final bool filled;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? hintStyle;

  const CustomInputField({
    Key? key,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    required this.labelText,
    this.suffixText,
    this.helperText,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.filled = false,
    this.floatingLabelBehavior,
    this.contentPadding = const EdgeInsets.all(12),
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      style: textStyle,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        suffixText: suffixText,
        helperText: helperText,
        border: border,
        focusedBorder: focusedBorder ?? OutlineInputBorder(borderSide: BorderSide(color: theme.dividerColor)),
        enabledBorder: enabledBorder ?? OutlineInputBorder(borderSide: BorderSide(color: theme.dividerColor)),
        filled: filled,
        floatingLabelBehavior: floatingLabelBehavior,
        contentPadding: contentPadding,
        hintStyle: hintStyle,
      ),
    );
  }
}
import 'package:flutter/services.dart';

class KeyboardConfig {
  final TextInputType keyboardType;
  final List<TextInputFormatter> formatters;
  final int? maxLength;

  KeyboardConfig({
    required this.keyboardType,
    required this.formatters,
    this.maxLength,
  });
}
import 'package:flutter/material.dart';

BoxDecoration decorationInitScreen() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF010426),
        Color(0xFF050816),
      ],
    ),
  );
}
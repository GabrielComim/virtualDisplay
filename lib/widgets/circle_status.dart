import 'package:flutter/material.dart';

// Widget para o círculo de status (verde para ativo, vermelho para inativo)
Widget circleStatus(bool isActive) {
  return Column(
    children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Colors.green : Colors.red,
        ),
      ),
    ],
  );
}

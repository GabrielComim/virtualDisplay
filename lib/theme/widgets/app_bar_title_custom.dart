import 'package:flutter/material.dart';

class AppBarTitleCustom extends StatelessWidget {
  final String textScreen;
  // Construtor
  const AppBarTitleCustom({super.key, required this.textScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      // Inicia o conteúdo do AppBar no início da tela, e não no centro.
      crossAxisAlignment: CrossAxisAlignment.start,
      // O AppBar tem a altura mínima necessária para o conteúdo, e não uma altura fixa.
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          textScreen,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]
    );
  }
}
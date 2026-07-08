import 'package:flutter/services.dart';
import 'package:virtual_display/models/cards_dashboard.dart';
import 'package:virtual_display/models/keyboard_config.dart';
import 'package:virtual_display/utils/constants.dart';

// O valor de leftExpression é o mesmo que card.title. Então preciso descobrir qual o card.type daquele card.title que estão em leftExpression
// Depois basta definir a configuração do teclado conforme o tipo

KeyboardConfig selectKeyboardConfig(
  List<CardsDashboard> cardList,
  String leftExpression,
) {
  CardsDashboard? card;
  try {
    card = cardList.firstWhere((card) => card.title == leftExpression);
  } catch (_) {
    return KeyboardConfig(
      keyboardType: TextInputType.text,
      formatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
    );
  }

  switch (card.type) {
    case Constants.cardTypeString:
      return KeyboardConfig(
        keyboardType: TextInputType.text,
        formatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
      );
    case Constants.cardTypeNumber:
      return KeyboardConfig(
        keyboardType: TextInputType.number,
        formatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
      );
    case Constants.cardTypeBool:
      return KeyboardConfig(
        keyboardType: TextInputType.number,
        formatters: [FilteringTextInputFormatter.allow(RegExp(r'[01]'))],
        maxLength: 1, // Limita a 1 dígito
      );
    default:
      return KeyboardConfig(
        keyboardType: TextInputType.text,
        formatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
      );
  }
}

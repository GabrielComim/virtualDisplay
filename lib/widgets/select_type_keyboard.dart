import 'package:flutter/services.dart';
import 'package:virtual_display/models/cards_dashboard.dart';
import 'package:virtual_display/utils/constants.dart';

// O valor de leftExpression é o mesmo que card.title. Então preciso descobrir qual o card.type daquele card.title que estão em leftExpression
// Depois basta definir a configuração do teclado conforme o tipo

TextInputFormatter selectTypeKeyboard(
  List<CardsDashboard> cardList,
  String leftExpression,
) {
  CardsDashboard? card;
  try {
    card = cardList.firstWhere((card) => card.title == leftExpression);
  } catch (_) {
    return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));
  }

  switch (card.id) {
    case Constants.cardTypeNumber:
      return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
    case Constants.cardTypeBool:
      return FilteringTextInputFormatter.allow(RegExp(r'[01]'));
    case Constants.cardTypeString:
      return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));
    default:
      return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  }
  // LengthLimitingTextInputFormatter(1),                      // Limita a 1 dígito
}

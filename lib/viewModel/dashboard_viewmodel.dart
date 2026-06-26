import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:virtual_display/models/cards_dashboard.dart';
import 'package:virtual_display/models/item_history.dart';
import 'package:virtual_display/models/chart_sample.dart';
import 'package:virtual_display/utils/constants.dart';

class DashboardViewmodel extends ChangeNotifier {
  List<CardsDashboard> cards = [];
  final Map<String, ItemHistory> history = {};
  
  void updateCards(List<CardsDashboard> newCards) {
    cards = newCards;
    notifyListeners();
  }

  void moveCard(int origem, int destino) {
    final item = cards.removeAt(origem);
    cards.insert(destino, item);
    notifyListeners();
  }

  void updateValues(Map<String, dynamic> json) {
    // Pega a data e hora atual que recebi o dado
    final now = DateTime.now();
    double value; 

    for(final card in cards) {
      if(json.containsKey(card.title)) {
        final key = card.title;
        final rawValue = json[card.title];
        card.value = rawValue.toString();
        log('${card.title}: ${card.value}');

        if(card.type == Constants.cardTypeBool) {
          value = rawValue == true ? 1.0 : 0.0;
        } else {
          value = double.tryParse(rawValue.toString()) ?? 0.0;
        }

        history.putIfAbsent(key, () => ItemHistory());

        history[key]!.add(
          ChartSample(timestamp: now, value: value)
        );
      }
    }
    notifyListeners();
  }
}
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:virtual_display/models/cards_dashboard.dart';
import 'package:virtual_display/models/item_history.dart';
import 'package:virtual_display/models/item_sample.dart';

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
    
    for(final card in cards) {
      if(json.containsKey(card.title)) {
        final valueStr = json[card.title].toString();
        card.value = json[card.title].toString();
        log('${card.title}: ${card.value}');

        final key = card.title;

        final value = double.tryParse(valueStr) ?? 0;

        history.putIfAbsent(key, () => ItemHistory());

        history[key]!.add(
          ItemSample(timestamp: now, value: value)
        );
      }
    }
    notifyListeners();
  }
}
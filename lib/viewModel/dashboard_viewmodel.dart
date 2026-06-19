import 'package:flutter/material.dart';
import 'package:virtual_display/models/cards_dashboard.dart';

class DashboardViewmodel extends ChangeNotifier {
  List<CardsDashboard> cards = [];

  void updateCards(List<CardsDashboard> newCards) {
    cards = newCards;
    notifyListeners();
  }
}
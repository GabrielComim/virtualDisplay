import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:virtual_display/models/cards_dashboard.dart';
import 'package:virtual_display/models/item_history.dart';
import 'package:virtual_display/models/chart_sample.dart';
import 'package:virtual_display/models/message_sample.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/widgets/list_accepted_types.dart';

// Filtra apenas os cards do dashboard que podem ser utilizados com o operador que foi escolhido
List<CardsDashboard> filterCards(List<CardsDashboard>? cards, String operator) {
  if (cards == null) return [];
  final validTypes = acceptedTypes(operator);
  final filtered = cards
      .where((card) => validTypes.contains(card.type))
      .toList();
  log(
    'Filtered cards for operator "$operator": ${filtered.map((c) => c.title).join(', ')}',
  );
  return filtered;
}

class DashboardViewmodel extends ChangeNotifier {
  List<CardsDashboard> _cards = [];

  List<CardsDashboard> get cards => List.unmodifiable(_cards);

  List<CardsDashboard> getCards(int brokerId, String deviceName) {
    return _cards
        .where(
          (card) => card.brokerId == brokerId && card.deviceName == deviceName,
        )
        .toList();
  }

  // Histórico de valores recebidos para cada card, armazenados por chave única (brokerId|deviceName)
  final Map<String, ItemHistory> history = {};

  // Histórico de mensagens recebidas, armazenadas por chave única (brokerId|deviceName|cardTitle)
  final Map<String, List<MessageSample>> messageHistory = {};

  // Gera uma chave única para o histórico de mensagens com base no brokerId, deviceName
  String _messageHistoryKey(int brokerId, String deviceName) {
    return '$brokerId|$deviceName';
  }

  // Adiciona uma nova mensagem ao histórico de mensagens
  void addMessage(
    int brokerId,
    String deviceName,
    String cardTitle,
    String value,
  ) {
    // log('Adicionando mensagem ao histórico: brokerId=$brokerId, deviceName=$deviceName, value=$value');

    final key = _messageHistoryKey(brokerId, deviceName);
    // Se a chave não existir, inicializa uma lista vazia para armazenar as mensagens
    messageHistory.putIfAbsent(key, () => []);
    messageHistory[key]!.insert(
      0,
      MessageSample(title: cardTitle, value: value, time: DateTime.now()),
    );
    // Limita o histórico a 100 mensagens por card
    if(messageHistory[key]!.length > 100) {
      messageHistory[key]!.removeLast(); // Mantém apenas as últimas 100 mensagens
    }
    notifyListeners();
  }

  // Retorna o histórico de mensagens para um card específico
  Map<String, ItemHistory> getHistory(int brokerId, String deviceName) {
    final prefix = '$brokerId|$deviceName|';
    return Map.fromEntries(
      history.entries.where((entry) => entry.key.startsWith(prefix)),
    );
  }

  List<MessageSample> getMessageHistory(
    int brokerId,
    String deviceName,
  ) {
    final key = _messageHistoryKey(brokerId, deviceName);
    return messageHistory[key] ?? [];
  }

  String historyKey(int brokerId, String deviceName, String cardTitle) {
    return '$brokerId|$deviceName|$cardTitle';
  }

  void updateCards(List<CardsDashboard> newCards) {
    if (newCards.isEmpty) return;

    final brokerId = newCards.first.brokerId;
    final deviceName = newCards.first.deviceName;

    _cards.removeWhere(
      (card) => card.brokerId == brokerId && card.deviceName == deviceName,
    );

    _cards.addAll(newCards);
    notifyListeners();
  }

  void updateButtonCard(
    int brokerId,
    String deviceName,
    String cardTitle,
    bool value,
  ) {
    final card = cards.firstWhere(
      (c) =>
          c.brokerId == brokerId &&
          c.deviceName == deviceName &&
          c.title == cardTitle,
    );
    card.value = value.toString();
    notifyListeners();
  }

  void moveCard(int origem, int destino) {
    final item = _cards.removeAt(origem);
    _cards.insert(destino, item);
    notifyListeners();
  }

  void updateValues(
    int brokerId,
    String deviceName,
    Map<String, dynamic> json,
  ) {
    // Pega a data e hora atual que recebi o dado
    final now = DateTime.now();
    double value;

    // Filtra os cards que pertencem ao broker e ao device específico
    final deviceCards = _cards.where(
      (c) => c.brokerId == brokerId && c.deviceName == deviceName,
    );

    for (final card in deviceCards) {
      if (json.containsKey(card.title)) {
        final key = historyKey(brokerId, deviceName, card.title);
        final rawValue = json[card.title];
        card.value = rawValue.toString();
        log('${card.title}: ${card.value}');

        if (card.type == Constants.cardTypeBool) {
          value = rawValue == true ? 1.0 : 0.0;
        } else {
          value = double.tryParse(rawValue.toString()) ?? 0.0;
        }

        history.putIfAbsent(key, () => ItemHistory());
        // Adiciona o novo valor ao histórico do card
        history[key]!.add(ChartSample(timestamp: now, value: value));
        // Só adiciona a mensagem ao histórico de mensagens se ela for do tipo String
        if(card.type == Constants.cardTypeString) {
          // Adiciona a mensagem ao histórico de mensagens do card
          addMessage(brokerId, deviceName, card.title, rawValue.toString());
        }
      }
    }
    notifyListeners();
  }

  CardsDashboard? getCardByType(String type) {
    try {
      return cards.firstWhere((c) => c.type == type);
    } catch (_) {
      return null;
    }
  }
}

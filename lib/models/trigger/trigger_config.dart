import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:virtual_display/models/automation.dart';
import 'package:virtual_display/models/cards_dashboard.dart';
import 'package:virtual_display/utils/constants.dart';

sealed class TriggerConfig {
  Map<String, dynamic> toJson();

  bool shouldFire(Automation automation, DateTime now, bool? currentCondition);

  DateTime? onExecuted(Automation automation);
}

// ======================== ONE SHOT ========================
class OneshotTrigger extends TriggerConfig {
  final DateTime dateTime;

  OneshotTrigger({required this.dateTime});

  OneshotTrigger copyWith({DateTime? dateTime}) {
    return OneshotTrigger(dateTime: dateTime ?? this.dateTime);
  }

  @override
  bool shouldFire(Automation automation, DateTime now, bool? currentCondition) {
    return automation.nextExecution != null &&
        ((now.isAfter(automation.nextExecution!) ||
            now.isAtSameMomentAs(automation.nextExecution!)));
  }

  @override
  DateTime? onExecuted(Automation automation) {
    return null;
  }

  @override
  factory OneshotTrigger.fromJson(Map<String, dynamic> json) {
    return OneshotTrigger(dateTime: DateTime.parse(json['dateTime'] as String));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': Constants.automationOneShot,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  @override
  String toString() {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
}

// ======================== PERIODIC ========================
class PeriodicTrigger extends TriggerConfig {
  final DateTime dateTime;
  final Duration interval;

  PeriodicTrigger({required this.dateTime, required this.interval});

  PeriodicTrigger copyWith({DateTime? dateTime, Duration? interval}) {
    return PeriodicTrigger(
      dateTime: dateTime ?? this.dateTime,
      interval: interval ?? this.interval,
    );
  }

  @override
  bool shouldFire(Automation automation, DateTime now, bool? currentCondition) {
    return automation.nextExecution != null &&
        ((now.isAfter(automation.nextExecution!) ||
            now.isAtSameMomentAs(automation.nextExecution!)));
  }

  @override
  DateTime? onExecuted(Automation automation) {
    DateTime next = automation.nextExecution!;
    // Atualiza a próxima execução
    do {
      next = next.add(interval);
    } while (!next.isAfter(DateTime.now()));

    log('NEXT EXECUTION: ${automation.nextExecution}');

    return next;
  }

  @override
  factory PeriodicTrigger.fromJson(Map<String, dynamic> json) {
    // log(json['dateTime'].toString());
    // log(json['intervalSeconds'].toString());
    return PeriodicTrigger(
      dateTime: DateTime.parse(json['dateTime'] as String),
      interval: Duration(seconds: json['intervalSeconds'] as int),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': Constants.automationPeriodic,
      'dateTime': dateTime.toIso8601String(),
      'intervalSeconds': interval.inSeconds,
    };
  }

  @override
  String toString() {
    return '${DateFormat('dd/MM/yyyy HH:mm').format(dateTime)} | ${interval.inHours}h ${interval.inMinutes.remainder(60)}m';
  }
}

// ======================== LOGICAL ========================
class LogicalTrigger extends TriggerConfig {
  final String? titleLogical;
  final String? leftOperand;
  final String? rightOperand;
  final String operator;
  final DateTime? dateTime;

  LogicalTrigger({
    this.titleLogical,
    this.leftOperand,
    this.rightOperand,
    required this.operator,
    this.dateTime,
  });

  LogicalTrigger copyWith({
    String? titleLogical,
    String? leftOperand,
    String? rightOperand,
    String? operator,
    DateTime? dateTime,
  }) {
    return LogicalTrigger(
      titleLogical: titleLogical ?? this.titleLogical,
      leftOperand: leftOperand ?? this.leftOperand,
      rightOperand: rightOperand ?? this.rightOperand,
      operator: operator ?? this.operator,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  dynamic _normalizeBool(dynamic value) {
    if (value is int) {
      if (value == 0) return false;
      if (value == 1) return true;
    }
    return value;
  }

  bool evaluate(List<CardsDashboard> cards) {
    final leftValue = _resolveOperand(leftOperand, cards);
    final rightValue = _resolveOperand(rightOperand, cards);
    final rightValueNormalized = _normalizeBool(rightValue);
    bool currentCondition;

    log(
      "LEFT: $leftValue - RIGHT: $rightValueNormalized - OPERATOR: $operator",
    );

    switch (operator) {
      case Constants.logicalConditionAnd:
        currentCondition =
            leftValue is bool &&
            rightValueNormalized is bool &&
            (leftValue && rightValueNormalized);
        break;
      case Constants.logicalConditionNot:
        currentCondition = leftValue != rightValueNormalized;
        break;

      case Constants.logicalConditionEqual:
        currentCondition =
            (leftValue.toString() == rightValueNormalized.toString());
        break;

      case Constants.logicalConditionMinor:
        currentCondition =
            leftValue is num &&
            rightValueNormalized is num &&
            leftValue < rightValueNormalized;
        break;

      case Constants.logicalConditionMinorEqual:
        currentCondition =
            leftValue is num &&
            rightValueNormalized is num &&
            leftValue <= rightValueNormalized;
        break;

      case Constants.logicalConditionMajor:
        currentCondition =
            leftValue is num &&
            rightValueNormalized is num &&
            leftValue > rightValueNormalized;
        break;

      case Constants.logicalConditionMajorEqual:
        currentCondition =
            leftValue is num &&
            rightValueNormalized is num &&
            leftValue >= rightValueNormalized;
        break;

      default:
        throw UnsupportedError('Operador $operator não suportado');
    }
    log('EVALUATE - CURRENT CONDITION: $currentCondition');
    return currentCondition;
  }

  @override
  bool shouldFire(
    // Está enviando todas as vezes, não está funcionando a lógica do shouldFire
    Automation automation,
    DateTime now,
    bool? currentCondition,
  ) {
    // Verifica se houve borda de disparo
    final shouldFire = !automation.lastCondition && (currentCondition ?? false);
    log(
      "current: $currentCondition   last: ${automation.lastCondition}  should fire logical: $shouldFire",
    );
    // Atualiza variável
    automation.lastCondition = (currentCondition ?? false);
    return shouldFire;
  }

  @override
  DateTime? onExecuted(Automation automation) {
    // Lógica a ser executada quando a automação for disparada
    return null;
  }

  @override
  factory LogicalTrigger.fromJson(Map<String, dynamic> json) {
    return LogicalTrigger(
      titleLogical: json['titleLogical'] as String?,
      leftOperand: json['leftOperand'] as String?,
      rightOperand: json['rightOperand'] as String?,
      operator: json['operator'] as String,
      dateTime: json['dateTime'] != null
          ? DateTime.parse(json['dateTime'] as String)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'titleLogical': titleLogical,
      'type': Constants.automationLogical,
      'leftOperand': leftOperand,
      'rightOperand': rightOperand,
      'operator': operator,
      'dateTime': dateTime?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return '$titleLogical $leftOperand $operator $rightOperand - ${dateTime != null ? DateFormat('dd/MM/yyyy HH:mm').format(dateTime!) : 'No date'}';
  }

  // Conforme o operand entrega o valor dele.
  dynamic _resolveOperand(String? operand, List<CardsDashboard> cards) {
    if (operand == null) {
      return null;
    }

    CardsDashboard? card;
    // Procura um card com o título
    for (final c in cards) {
      if (c.title == operand) {
        card = c;
      }
    }

    if (card != null) {
      if(card.type == Constants.cardTypeBool) {
        return  card.value.toString().toLowerCase() == 'true';
      }
      if(card.type == Constants.cardTypeNumber) {
        return num.tryParse(card.value.toString());
      }
      return card.value;
    }

    final number = num.tryParse(operand);
    if (number != null) {
      return number;
    }

    final lower = operand.toLowerCase();

    if (lower == 'true' || lower == '1') {
      return true;
    }

    if (lower == 'false' || lower == '0') {
      return false;
    }

    return operand;
  }
}

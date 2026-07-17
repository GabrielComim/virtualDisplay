import 'package:intl/intl.dart';
import 'package:virtual_display/models/automation.dart';
import 'package:virtual_display/models/cards_dashboard.dart';
import 'package:virtual_display/utils/constants.dart';

sealed class TriggerConfig {
  Map<String, dynamic> toJson();

  bool shouldFire(
    Automation automation,
    DateTime now,
    List<CardsDashboard> cards,
  );

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
  bool shouldFire(
    Automation automation,
    DateTime now,
    List<CardsDashboard> cards,
  ) {
    return automation.nextExecution != null &&
        ((now.isAfter(automation.nextExecution!) ||
            now.isAtSameMomentAs(automation.nextExecution!)));
  }

  @override
  DateTime? onExecuted(Automation automation) {
    // Lógica a ser executada quando a automação for disparada
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
  bool shouldFire(
    Automation automation,
    DateTime now,
    List<CardsDashboard> cards,
  ) {
    return automation.nextExecution != null &&
        ((now.isAfter(automation.nextExecution!) ||
            now.isAtSameMomentAs(automation.nextExecution!)));
  }

  @override
  DateTime? onExecuted(Automation automation) {
    // Lógica a ser executada quando a automação for disparada
    return automation.nextExecution!.add(interval);
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

  @override
  bool shouldFire(
    Automation automation,
    DateTime now,
    List<CardsDashboard> cards,
  ) {
    final leftValue = _resolveOperand(leftOperand, cards);
    final rightValue = _resolveOperand(rightOperand, cards);
    bool currentCondition;

    switch (operator) {
      case Constants.logicalConditionAnd:
        currentCondition =
            leftValue is bool && rightValue is bool && leftValue && rightValue;
        break;
      case Constants.logicalConditionOr:
        currentCondition =
            leftValue is bool &&
            rightValue is bool &&
            (leftValue || rightValue);
        break;
      case Constants.logicalConditionNot:
        currentCondition = leftValue != rightValue;
        break;

      case Constants.logicalConditionEqual:
        currentCondition = leftValue == rightValue;
        break;

      case Constants.logicalConditionMinor:
        currentCondition =
            leftValue is num && rightValue is num && leftValue < rightValue;
        break;

      case Constants.logicalConditionMinorEqual:
        currentCondition =
            leftValue is num && rightValue is num && leftValue <= rightValue;
        break;

      case Constants.logicalConditionMajor:
        currentCondition =
            leftValue is num && rightValue is num && leftValue > rightValue;
        break;

      case Constants.logicalConditionMajorEqual:
        currentCondition =
            leftValue is num && rightValue is num && leftValue >= rightValue;
        break;

      default:
        throw UnsupportedError('Operador $operator não suportado');
    }

    // Verifica se houve borda de disparo
    final shouldFire = !automation.lastCondition && currentCondition;
    // Atualiza variável
    automation.lastCondition = currentCondition;

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
    // Procura um car com o título
    for (final c in cards) {
      if (c.title == operand) {
        card = c;
        break;
      }
    }

    if (card != null) {
      return card.value;
    }

    final number = num.tryParse(operand);
    if (number != null) {
      return number;
    }

    final lower = operand.toLowerCase();

    if (lower == 'true') {
      return true;
    }

    if (lower == 'false') {
      return false;
    }

    return operand;
  }
}

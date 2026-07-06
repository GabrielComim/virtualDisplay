import 'package:intl/intl.dart';
import 'package:virtual_display/utils/constants.dart';

sealed class TriggerConfig {
  Map<String, dynamic> toJson();
}

// ======================== ONE SHOT ========================
class OneshotTrigger extends TriggerConfig {
  final DateTime dateTime;

  OneshotTrigger({
    required this.dateTime,
  });

  OneshotTrigger copyWith({
    DateTime? dateTime,
  }) {
    return OneshotTrigger(
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  factory OneshotTrigger.fromJson(Map<String, dynamic> json) {
    return OneshotTrigger(
      dateTime: DateTime.parse(json['dateTime'] as String),
    );
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

  PeriodicTrigger({
    required this.dateTime,
    required this.interval,
  });

  PeriodicTrigger copyWith({
    DateTime? dateTime,
    Duration? interval
  }) {
    return PeriodicTrigger(
      dateTime: dateTime ?? this.dateTime,
      interval: interval ?? this.interval,
    );
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
  Map<String, dynamic> toJson(){
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
class LogicalTrigger extends TriggerConfig{
  final String? leftExpression;
  final String? rightExpression;
  final String operator;
  final DateTime? dateTime;

  LogicalTrigger({
    this.leftExpression,
    this.rightExpression,
    required this.operator,
    this.dateTime,
  });

   LogicalTrigger copyWith({
    String? leftExpression,
    String? rightExpression,
    String? operator,
    DateTime? dateTime,
  }) {
    return LogicalTrigger(
      leftExpression: leftExpression ?? this.leftExpression,
      rightExpression: rightExpression ?? this.rightExpression,
      operator: operator ?? this.operator,
      dateTime: dateTime ?? this.dateTime,
    );
  }


  @override
  factory LogicalTrigger.fromJson(Map<String, dynamic> json) {
    return LogicalTrigger(
      leftExpression: json['leftExpression'] as String?,
      rightExpression: json['rightExpression'] as String?,
      operator: json['operator'] as String,
      dateTime: json['dateTime'] != null ? DateTime.parse(json['dateTime'] as String) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': Constants.automationLogical,
      'leftExpression': leftExpression,
      'rightExpression': rightExpression,
      'operator': operator,
      'dateTime': dateTime?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return '$leftExpression $operator $rightExpression - ${dateTime != null ? DateFormat('dd/MM/yyyy HH:mm').format(dateTime!) : 'No date'}';
  }
}
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
}

// ======================== PERIODIC ========================
class PeriodicTrigger extends TriggerConfig {
  final DateTime startDate;
  final Duration interval;

  PeriodicTrigger({
    required this.startDate,
    required this.interval,
  });

  @override
  factory PeriodicTrigger.fromJson(Map<String, dynamic> json) {
    return PeriodicTrigger(
      startDate: DateTime.parse(json['startDate'] as String),
      interval: Duration(seconds: json['intervalSeconds'] as int),
    );
  }

  @override
  Map<String, dynamic> toJson(){
    return {
      'type': Constants.automationPeriodic,
      'startTime': startDate.toIso8601String(),
      'intervalSeconds': interval.inSeconds,
    };
  }
}

// ======================== LOGICAL ========================
class LogicalTrigger extends TriggerConfig{
  final String expression;
  final DateTime? validAfter;

  LogicalTrigger({
    required this.expression,
    this.validAfter,
  });

  @override
  factory LogicalTrigger.fromJson(Map<String, dynamic> json) {
    return LogicalTrigger(
      expression: json['expression'] as String,
      validAfter: json['validAfter'] != null ? DateTime.parse(json['validAfter'] as String) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': Constants.automationLogical,
      'expression': expression,
      'validAfter': validAfter?.toIso8601String(),
    };
  }
}
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
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
}

// ======================== LOGICAL ========================
class LogicalTrigger extends TriggerConfig{
  final String expression;
  final DateTime? dateTime;

  LogicalTrigger({
    required this.expression,
    this.dateTime,
  });

   LogicalTrigger copyWith({
    String? expression,
    DateTime? dateTime,
  }) {
    return LogicalTrigger(
      expression: expression ?? this.expression,
      dateTime: dateTime ?? this.dateTime,
    );
  }


  @override
  factory LogicalTrigger.fromJson(Map<String, dynamic> json) {
    return LogicalTrigger(
      expression: json['expression'] as String,
      dateTime: json['dateTime'] != null ? DateTime.parse(json['dateTime'] as String) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': Constants.automationLogical,
      'expression': expression,
      'dateTime': dateTime?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime!);
  }
}
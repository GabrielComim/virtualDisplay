import 'dart:convert';
import 'package:virtual_display/models/action/action_publish.dart';
import 'package:virtual_display/models/trigger/trigger_config.dart';
import 'package:virtual_display/utils/constants.dart';

class Automation {
  final int? id;
  String name;
  String type;
  bool enable;
  ActionConfig action;
  TriggerConfig trigger;
  DateTime? nextExecution;
  bool lastCondition;

  Automation({
    required this.id,
    required this.name,
    required this.type,
    required this.enable,
    required this.action,
    required this.trigger,
    this.nextExecution,
    required this.lastCondition,
  });

  Automation copyWith({
    int? id,
    String? name,
    String? type,
    bool? enable,
    ActionConfig? action,
    TriggerConfig? trigger,
    DateTime? nextExecution,
    bool? lastCondition,
  }) {
    return Automation(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      enable: enable ?? this.enable,
      action: action ?? this.action,
      trigger: trigger ?? this.trigger,
      nextExecution: nextExecution ?? this.nextExecution,
      lastCondition: lastCondition ?? this.lastCondition,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "type": type,
      "enable": enable ? 1 : 0,
      "action": jsonEncode(action.toJson()),
      "trigger": jsonEncode(trigger.toJson()),
      "nextExecution": nextExecution?.toIso8601String(),
      "lastCondition": lastCondition ? 1 : 0,
    };
  }

  factory Automation.fromMap(Map<String, dynamic> map) {
    final triggerMap = jsonDecode(map['trigger']) as Map<String, dynamic>;
    final actionMap = jsonDecode(map['action']) as Map<String, dynamic>;
    late final ActionConfig action;
    late final TriggerConfig trigger;

    switch(map['type'] as String) {
      case Constants.automationOneShot:
        trigger = OneshotTrigger.fromJson(triggerMap);
        action = PublishAction.fromJson(actionMap);
        break;
      case Constants.automationPeriodic:
        // log('Periodic trigger map: $triggerMap');
        trigger = PeriodicTrigger.fromJson(triggerMap);
        action = PublishAction.fromJson(actionMap);
        break;
      case Constants.automationLogical:
        trigger = LogicalTrigger.fromJson(triggerMap);
        action = PublishAction.fromJson(actionMap);
        break;
      default: 
        throw Exception('Tipo de automação desconhecido: ${map['type']}');
    }

    return Automation(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: map['type'] as String,
      enable: (map['enable'] as int) == 1,
      action: action,
      trigger: trigger,
      nextExecution: map['nextExecution'] != null ? DateTime.tryParse(map['nextExecution']) : null,
      lastCondition: (map['lastCondition'] as int) == 1,
    );
  }
}
import 'package:virtual_display/utils/constants.dart';

sealed class ActionConfig {
  Map<String, dynamic> toJson();
}

class PublishAction extends ActionConfig {
  final String topic;
  final String payload;
  final int qos;
  final bool retain;

  PublishAction({
    required this.topic,
    required this.payload,
    this.qos = 0,
    this.retain = false,
  });

  PublishAction copyWith({
    String? topic,
    String? payload,
    int? qos,
    bool? retain,
  }) {
    return PublishAction(
      topic: topic ?? this.topic,
      payload: payload ?? this.payload,
      qos: qos ?? this.qos,
      retain: retain ?? this.retain,
    );
  }

  @override
  factory PublishAction.fromJson(Map<String, dynamic> json) {
    return PublishAction(
      topic: json['topic'] as String,
      payload: json['payload'] as String,
      qos: json['qos'] as int,
      retain: json['retain'] as bool,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': Constants.actionPublish,
      'topic': topic,
      'payload': payload,
      'qos': qos,
      'retain': retain,
    };
  }
}
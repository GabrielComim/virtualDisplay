import 'dart:developer';

import 'package:virtual_display/services/mqtt/mqtt_topics.dart';
import 'package:virtual_display/services/mqtt_services.dart';

void topicsInitConfig(MqttServices mqttService) {
  log('SUBSCRIBE: ${MqttTopics.config()}');
  // Tópico que recebe a configuração 
  mqttService.subscribe(MqttTopics.config());
  mqttService.subscribe(MqttTopics.configAck());
}

void topicsInitDataAndButton(MqttServices mqttService) {
  mqttService.subscribe(MqttTopics.data('+'));
  mqttService.subscribe(MqttTopics.button('+'));
}
import 'dart:convert';

import 'package:virtual_display/services/mqtt/mqtt_services.dart';
import 'package:virtual_display/utils/constants.dart';

// Implementa-se aqui o envio de mensagens para o broker
class MqttPublish {
  final MqttServices mqttService;
  
  // construtor
  MqttPublish(this.mqttService);

  // Solicita nome do dispositivo
  void requestDeviceName() {
    mqttService.publish(Constants.mqttTopicRequestDevice, jsonEncode({'command': 'getDeviceName'}));
  }
  // Solicita a configuração inicial ao dispositivo
  void requestConfig() {
    mqttService.publish(Constants.mqttTopicConfig, jsonEncode({'command': 'getConfig'}));
  }

  // Confirma que recebeu a configuração inicial
  void configAck() {
    mqttService.publish(Constants.mqttTopicConfigAck, jsonEncode({'received': 'true'}));
  }
}

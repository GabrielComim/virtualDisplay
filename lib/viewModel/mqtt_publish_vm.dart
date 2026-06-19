import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:virtual_display/services/mqtt_services.dart';
import 'package:virtual_display/utils/constants.dart';

// Implementa-se aqui o envio de mensagens para o broker
class MqttPublishVm extends ChangeNotifier{
  // Solicita a configuração inicial ao dispositivo
  void requestConfig() {
    MqttServices().publish(Constants.mqttTopicConfig, jsonEncode({'command': 'getConfig'}));
  }

  // Confirma que recebeu a configuração inicial
  void configAck() {
    MqttServices().publish(Constants.mqttTopicConfigAck, jsonEncode({'received': 'true'}));
  }
}

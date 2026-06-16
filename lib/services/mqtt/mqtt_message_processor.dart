import 'dart:developer';

import 'package:virtual_display/utils/constants.dart';

// Implementa-se aqui o recebimento de mensagens via MQTT
class MqttMessageProcessor {
  void process(String topic, String payload) {
    if(topic.endsWith(Constants.topicConfig)) {
        _processConfig(payload);
    } else if(topic.endsWith(Constants.topicData)) {
      _processData(payload);
    } else if(topic.endsWith(Constants.topicRequestConfig)) {
    } else if(topic.endsWith(Constants.topicConfigAck)) {
    } else {
      log('MENSAGEM AINDA NÃO IMPLEMENTADA: $payload');
    }
  }

  void _processConfig(String payload) {
    // Converte o payload recebido de JSON para cada variável desejada
  }
  
  void _processData(String payload) {

  }
}
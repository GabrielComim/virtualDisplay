import 'dart:convert';
import 'dart:developer';

import 'package:virtual_display/models/device_info.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/viewModel/devices_viewmodel.dart';

// Implementa-se aqui o recebimento de mensagens via MQTT
class MqttMessageProcessor {
  void process(String topic, String payload) {
    if(topic.endsWith(Constants.topicConfig)) {
        _processConfig(payload);
    } 
    else if(topic.endsWith(Constants.topicData)) {
      _processData(payload);
    } 
    else if(topic.endsWith(Constants.topicRequestConfig)) {
    } 
    else if(topic.endsWith(Constants.topicConfigAck)) {
    } 
    else if(topic.endsWith(Constants.topicResponseDevice)) {
      _processRequestDevice(payload);
    } 
    else {
      log('MENSAGEM AINDA NÃO IMPLEMENTADA: $payload');
    }
  }

  void _processConfig(String payload) {
    // Converte o payload recebido de JSON para cada variável desejada
  }
  
  void _processData(String payload) {

  }

  void _processRequestDevice(String payload) {
    final decodePayload = jsonDecode(payload);
    DevicesViewModel().addDevice(DeviceInfo(device: 'dispositivo1', online: true));
    
    log('Request device: $decodePayload');
  }
}
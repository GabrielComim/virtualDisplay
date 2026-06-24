import 'dart:convert';
import 'dart:developer';

import 'package:virtual_display/models/cards_dashboard.dart';
import 'package:virtual_display/models/device_info.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/viewModel/devices_viewmodel.dart';
import 'package:virtual_display/viewModel/mqtt_publish_vm.dart';

// Implementa-se aqui o recebimento de mensagens via MQTT
class MqttMessageProcessor {
  final DevicesViewModel devicesViewModel;
  final MqttPublishVm mqttPublishViewModel;
  final DashboardViewmodel dashboardViewmodel;

  String? _currentDevice;

  // Construtor
  MqttMessageProcessor(
    this.devicesViewModel,
    this.mqttPublishViewModel,
    this.dashboardViewmodel,
  );

  void process(String topic, String payload) {
    try {
      final Map<String, dynamic> json = jsonDecode(payload);
      
      // Recebe as configurações
      if (topic.endsWith(Constants.topicResponseConfig)) {
        _processConfig(json);
        // Confirma recebimento das configurações iniciais
        mqttPublishViewModel.configAck();
      }
      
      // recebe o valor de cada item
      else if (topic.endsWith(Constants.topicData)) {
        log('Data recebido');
        _processData(json);
      } 
      
      else {
        log('MENSAGEM AINDA NÃO IMPLEMENTADA: $payload');
      }
    } 
    
    catch (e) {
      log('Erro ao decodificar o JSON: $e');
    }
  }

  // Processa a mensagem com as configurações iniciais
  void _processConfig(Map<String, dynamic> json) {
    List<CardsDashboard> widgets = (json['widgets'] as List)
        .map((item) => CardsDashboard.fromJson(item))
        .toList();
    
    final String deviceName = json['device'] ?? '';
    
    // Atualiza a variável
    _currentDevice = deviceName;

    devicesViewModel.addDevice(DeviceInfo(device: deviceName, online: true));

    // for (final widget in widgets) {
    //   log('Card: ${widget.title}');
    // }
    // Cria os cards conforme o que recebeu via MQTT
    dashboardViewmodel.updateCards(widgets);
  }

  void _processData(Map<String, dynamic> json) {
    final values = json['values'] as Map<String, dynamic>;

    // final device = _currentDevice ?? '--';
    
    // final mapped = values.map((key, value) {
    //   return MapEntry(
    //     '$device.$key',
    //     value,
    //   );
    // });

    dashboardViewmodel.updateValues(values);
  }
}

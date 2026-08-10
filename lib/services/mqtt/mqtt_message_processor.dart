import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:developer' as developer;

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
  final int? credentialBroker;

  // String? _currentDevice;
  final math.Random _random = math.Random();
  Timer? _timer;

  // Construtor
  MqttMessageProcessor(
    this.devicesViewModel,
    this.mqttPublishViewModel,
    this.dashboardViewmodel,
    this.credentialBroker,
  );

  void process(String topic, String payload) {
    try {
      final Map<String, dynamic> json = jsonDecode(payload);

      //  RECEBE CONFIGURAÇÕES INICIAIS DO DISPOSITIVO
      if (topic.endsWith(Constants.topicResponseConfig)) {
        developer.log('Config recebido');
        _processConfig(json);
        // Confirma recebimento das configurações iniciais
        mqttPublishViewModel.configAck();
      }
      // RECEBE DADOS DO DISPOSITIVO
      else if (topic.endsWith(Constants.topicData)) {
        developer.log('Data recebido');

        // Procura o nome do dispositivo no tópico MQTT
        final deviceNameFromTopic = topic.split('/')[1];
        _processData(json, deviceNameFromTopic);
      }
      // RECEBE OS VALORES DOS BOTÕES
      else if (topic.contains(Constants.mqttTopicButtonAck)) {
        developer.log('Button recebido');
        // Pega qual card alterou valor
        final cardTitle = topic.split('/').last;
        // Processa o valor recebido de um botão
        final value = _processButton(json);
        // Atualiza os cards do dashboard
        dashboardViewmodel.updateButtonCard(
          credentialBroker ?? 0,
          json['device'] ?? '',
          cardTitle,
          value,
        );

        // MENSAGEM DESCONHECIDA
      } else {
        developer.log('MENSAGEM AINDA NÃO IMPLEMENTADA: $payload');
      }
    } catch (e) {
      developer.log('Erro ao decodificar o JSON: $e');
    }
  }

  // Processa a mensagem com as configurações iniciais
  void _processConfig(Map<String, dynamic> json) {
    final String deviceName = json['device'] ?? '';

    List<CardsDashboard> widgets = (json['widgets'] as List)
        .map(
          (item) =>
              CardsDashboard.fromJson(item, credentialBroker ?? 0, deviceName),
        )
        .toList();

    devicesViewModel.addDevice(
      DeviceInfo(
        brokerId: credentialBroker ?? 0,
        device: deviceName,
        online: true,
      ),
    );

    // Atualiza os cards conforme o que recebeu via MQTT
    dashboardViewmodel.updateCards(widgets);
  }

  void _processData(Map<String, dynamic> json, String deviceName) {
    final values = json['values'] as Map<String, dynamic>;
    dashboardViewmodel.updateValues(credentialBroker ?? 0, deviceName, values);
    log('Valores atualizados para o dispositivo $deviceName: $values');
  }

  bool _processButton(Map<String, dynamic> json) {
    return json['button'] as bool;
  }

  // *********************** MODO DEMONSTRAÇÃO ***********************

  // Gera dados acom valores aleatórios para atualizar e gerar um gráfico
  Map<String, dynamic> _generateDemoData() {
    return {
      "device": Constants.jsonConfigTestDeviceName,
      "values": {
        "Sensor temp.": (_random.nextDouble() * 20).toStringAsFixed(2),
        "Veloc.": _random.nextInt(201).toString(),
        "Lamp. 1": _random.nextBool(),
        "Lamp. 2": _random.nextBool(),
        "Alertas": _random.nextBool() ? "Sistema OK" : "Erro na comunicação",
      },
    };
  }

  void stopDemonstrationMode() {
    _timer?.cancel();
    _timer = null;
  }

  void initDemonstrationMode() {
    // Mensagem com a configuração
    String payloadConfig = Constants.jsonConfigTest;

    try {
      // Configura os widgets de demonstração
      final Map<String, dynamic> jsonConfig = jsonDecode(payloadConfig);
      _processConfig(jsonConfig);
  
      // Enviar dados a cada 3 segundos.
      _timer = Timer.periodic(Duration(seconds: 3), (_) {
        _processData(_generateDemoData(), Constants.jsonConfigTestDeviceName);
      });
    } catch (e) {
      developer.log('Erro ao decodificar o JSON: $e');
    }
  }
}

import 'dart:async';
import 'dart:convert';
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

  // String? _currentDevice;
  final math.Random _random = math.Random();
  Timer? _timer;

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
        developer.log('Data recebido');
        _processData(json);
      }
      // recebe dados do botão
      else if (topic.contains(Constants.mqttTopicButton)) {
        developer.log('Button recebido');
        // Pega qual card alterou valor
        final cardTitle = topic.split('/').last;
        // Processa o valor recebido de um botão
        final value = _processButton(json);
        // Atualiza os cards do dashboard
        dashboardViewmodel.updateButtonCard(cardTitle, value);
      } else {
        developer.log('MENSAGEM AINDA NÃO IMPLEMENTADA: $payload');
      }
    } catch (e) {
      developer.log('Erro ao decodificar o JSON: $e');
    }
  }

  // Processa a mensagem com as configurações iniciais
  void _processConfig(Map<String, dynamic> json) {
    List<CardsDashboard> widgets = (json['widgets'] as List)
        .map((item) => CardsDashboard.fromJson(item))
        .toList();

    final String deviceName = json['device'] ?? '';

    // Atualiza a variável
    // _currentDevice = deviceName;

    devicesViewModel.addDevice(DeviceInfo(device: deviceName, online: true));

    // for (final widget in widgets) {
    //   developer.log('Card: ${widget.title}');
    // }
    // Atualiza os cards conforme o que recebeu via MQTT
    dashboardViewmodel.updateCards(widgets);
  }

  void _processData(Map<String, dynamic> json) {
    final values = json['values'] as Map<String, dynamic>;
    dashboardViewmodel.updateValues(values);
  }

  bool _processButton(Map<String, dynamic> json) {
    return json['button'] as bool;
  }

  // *********************** MODO DEMONSTRAÇÃO ***********************
  
  // Gera dados acom valores aleatórios para atualizar e gerar um gráfico
  Map<String, dynamic> _generateDemoData() {
    return {
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
      _timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => _processData(_generateDemoData()),
      );
    } catch (e) {
      developer.log('Erro ao decodificar o JSON: $e');
    }
  }
}

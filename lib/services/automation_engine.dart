// Lê as automações, verifica horários e lógica para então fazer o envio via MQTT.
// Deve ser código de negócio, sem BuildContext, scaffold, widget.
// Deve conhecer apenas o trigger.
// Criar um timer que acorda a Engine e verifica se tem alguma automação para ser executada.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/viewModel/mqtt_publish_vm.dart';

class AutomationEngine extends StatefulWidget {
  final Widget child;

  // Construtor
  const AutomationEngine({super.key, required this.child});

  @override
  State<AutomationEngine> createState() => _AutomationEngineState();
}

class _AutomationEngineState extends State<AutomationEngine> {
  static Timer? _timer;

  @override 
  void initState() {
    super.initState();
    startEngine();
    executeAutomation();
  }

  void _shouldFireAutomation() {
    
  }

  void startEngine() {
    // Iniciar o timer que acorda a Engine e verifica se tem alguma automação para ser executada.
        _timer = Timer(Duration(minutes: 1), () {
          // verifica se deve disparar alguma automação
          _shouldFireAutomation(); 
        });

  }

  void loadAutomations() {
    // Lê as automações, verifica horários e lógica para então fazer o envio via MQTT.
  }

  void executeAutomation() {
    // Executa a automação, enviando via MQTT.
    final MqttPublishVm mqttPublish = context.read<MqttPublishVm>();
    mqttPublish.sendAutomation();
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

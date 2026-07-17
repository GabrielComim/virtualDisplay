// Lê as automações, verifica horários e lógica para então fazer o envio via MQTT.
// Deve ser código de negócio, sem BuildContext, scaffold, widget.
// Deve conhecer apenas o trigger.
// Criar um timer que acorda a Engine e verifica se tem alguma automação para ser executada.

import 'dart:async';

import 'package:virtual_display/models/action/action_publish.dart';
import 'package:virtual_display/models/automation.dart';
import 'package:virtual_display/viewModel/automations_viewmodel.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/viewModel/mqtt_publish_vm.dart';

class AutomationEngine {
  final AutomationsViewmodel automationsVm;
  final DashboardViewmodel dashboardVm;
  final MqttPublishVm mqttPublishVm;

  Timer? _timer;

  AutomationEngine({
    required this.automationsVm,
    required this.dashboardVm,
    required this.mqttPublishVm,
  });

  void start() {
    stop();

    // Verifica imediatamente
    checkAutomations();

    // Depois verifica periodicamente
    _timer = Timer.periodic(Duration(seconds: 1), (_) => checkAutomations());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> checkAutomations() async {
    final now = DateTime.now();

    for (final automation in automationsVm.automations) {
      if (!automation.enable) {
        continue;
      }

      final shouldFire = automation.trigger.shouldFire(
        automation,
        now,
        dashboardVm.cards,
      );

      if (!shouldFire) {
        continue;
      }

      await executeAutomation(automation);

      automation.nextExecution = automation.trigger.onExecuted(automation);
      final automations = List<Automation>.from(automationsVm.automations);
      for (final automation in automations) {
        await automationsVm.updateAutomation(automation);
      }
    }
  }

  Future<void> executeAutomation(Automation automation) async {
    mqttPublishVm.sendAutomation(
      (automation.action as PublishAction).topic,
      (automation.action as PublishAction).payload,
    );
  }
}

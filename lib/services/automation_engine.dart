// Lê as automações, verifica horários e lógica para então fazer o envio via MQTT.
// Deve ser código de negócio, sem BuildContext, scaffold, widget.
// Deve conhecer apenas o trigger.
// Criar um timer que acorda a Engine e verifica se tem alguma automação para ser executada.

import 'dart:async';
// import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/models/action/action_publish.dart';
import 'package:virtual_display/models/automation.dart';
import 'package:virtual_display/models/trigger/trigger_config.dart';
import 'package:virtual_display/viewModel/automations_viewmodel.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/viewModel/mqtt_publish_vm.dart';

class AutomationEngine {
  final AutomationsViewmodel automationsVm;
  final DashboardViewmodel dashboardVm;
  final MqttPublishVm mqttPublishVm;

  bool _running = false;
  Timer? _timer;

  AutomationEngine({
    required this.automationsVm,
    required this.dashboardVm,
    required this.mqttPublishVm,
  });

  void startAutomation(BuildContext context) {
    if (_running) return;
    _running = true;
    // Garante que não ficará 2 timers rodando juntos para a mesma coisa
    stopAutomation();
    
    final provider = Provider.of<AutomationsViewmodel>(context, listen: false);
    provider.loadAutomations();
    
    // Verifica imediatamente
    checkAutomations();

    // Depois verifica periodicamente
    _timer = Timer.periodic(Duration(seconds: 10), (_) => checkAutomations());
  }

  void stopAutomation() {
    _timer?.cancel();
    _timer = null;
    _running = false;
  }

  Future<void> checkAutomations() async {
    final now = DateTime.now();
    bool shouldFire = false;
    for (final automation in automationsVm.automations) {
      if (!automation.enable) {
        continue;
      }

      if (automation.trigger is LogicalTrigger) {
        // Avalia se mudou o valor da condição de borda para salvar o automation
        final currentCondition = (automation.trigger as LogicalTrigger)
            .evaluate(dashboardVm.cards);

        // Verifica se deve disparar a automação - TRIGGER LÓGICO
        shouldFire = automation.trigger.shouldFire(
          automation,
          now,
          currentCondition,
        );
        await automationsVm.updateAutomation(automation);
      } else {
        // TRIGGER ONE SHOT OU PERIÓDICO
        shouldFire = automation.trigger.shouldFire(
          automation,
          now,
          null
        );
      }

      // MOSTRAR PARA DEBUG: AUTOMAÇÕES ATIVAS E PRÓXIMA EXECUÇÃO
      // log('AUTOMAÇÃO: ${automation.name}: NextExecution: ${automation.nextExecution}');
      // log('SHOULD FIRE: $shouldFire');

      if (!shouldFire) {
        continue;
      }
      // log('EXECUTE AUTOMATION');
      await executeAutomation(automation);
      // Executa a automação
      automation.nextExecution = automation.trigger.onExecuted(automation);
      await automationsVm.updateAutomation(automation);
    }
  }

  Future<void> executeAutomation(Automation automation) async {
    mqttPublishVm.sendAutomation(
      (automation.action as PublishAction).topic,
      (automation.action as PublishAction).payload,
    );
  }

  Future<void> onCardChanged() async {
    // Se alterar o valor de um card para o logicalTrigger faz a alteração para detectar borda
  }

  void updateCard() {}
}

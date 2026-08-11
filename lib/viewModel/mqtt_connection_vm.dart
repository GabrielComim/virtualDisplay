import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/credentials_broker.dart';
import 'package:virtual_display/services/automation_engine.dart';
import 'package:virtual_display/services/mqtt/mqtt_message_processor.dart';
import 'package:virtual_display/services/mqtt/topic_manager.dart';
import 'package:virtual_display/services/mqtt_services.dart';
import 'package:virtual_display/viewModel/automations_viewmodel.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/viewModel/devices_viewmodel.dart';
import 'package:virtual_display/viewModel/mqtt_publish_vm.dart';
import 'package:virtual_display/widgets/show_material_banner.dart';

class MqttConnectionVm extends ChangeNotifier {
  // ================= CONEXÃO MQTT =================
  Future<bool> initConnectMqtt(
    BuildContext context,
    CredentialsBroker broker,
  ) async {
    // Busca o valor no provider
    final devicesViewModel = context.read<DevicesViewModel>();
    final MqttPublishVm mqttPublishViewModel = context.read<MqttPublishVm>();
    final DashboardViewmodel dashboardViewmodel = context
        .read<DashboardViewmodel>();
    final AutomationsViewmodel automationVm = context
        .read<AutomationsViewmodel>();

    // Cria a instância para processar as mensagens que chegarem - indica a função que vai processar as mensagens
    final mqttProcessor = MqttMessageProcessor(
      devicesViewModel,
      mqttPublishViewModel,
      dashboardViewmodel,
      broker.id
    );
    MqttServices().onMessageReceived = mqttProcessor.process;

    // Tenta se conectar ao ligar o aplicativo
    final isConnected = await mqttConnection(context, broker);

    if (isConnected) {
      // Increve-se nos tópicos necessários
      topicsInitConfig(MqttServices());
      // Inscreve-se nos tópicos para receber os dados e publicar nos botões
      topicsInitDataAndButton(MqttServices());
      
      // Inicia as automações
      if (context.mounted) {
        AutomationEngine(
          automationsVm: automationVm,
          dashboardVm: dashboardViewmodel,
          mqttPublishVm: mqttPublishViewModel,
        ).startAutomation(context);
      }
      log('DEVERIA INICIAR AS AUTOMAÇÕES NESTE PONTO');
      // Falhou na conexão
    } 
    return isConnected;
  }

  void mqttRequestConfig(BuildContext context) {
    final MqttPublishVm mqttPublishViewModel = context.read<MqttPublishVm>();
    // Solicita as configurações
    mqttPublishViewModel.requestConfig();
  }

  Future<bool> mqttConnection(
    BuildContext context,
    CredentialsBroker credentials,
  ) async {
    log('Broker: ${credentials.broker}');
    log('User: ${credentials.username}');
    log('Password: ${credentials.password}');
    log('TLS: ${credentials.tls}');
    final connected = await MqttServices().connect(
      broker: credentials.broker,
      clientId: 'client_app',
      port: credentials.tls ? 8883 : 1883,
      tls: credentials.tls,
      credentialName: credentials.username,
      credentialPassword: credentials.password,
    );
    return connected;
  }
}

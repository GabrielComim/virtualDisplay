import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/services/mqtt/mqtt_message_processor.dart';
import 'package:virtual_display/services/mqtt/topic_manager.dart';
import 'package:virtual_display/services/mqtt_services.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/viewModel/devices_viewmodel.dart';
import 'package:virtual_display/viewModel/mqtt_publish_vm.dart';

class MqttConnectionVm extends ChangeNotifier {
  Future<void> initConnectMqtt(BuildContext context) async {
    // Busca o valor no provider
    final devicesViewModel = context.read<DevicesViewModel>();
    final MqttPublishVm mqttPublishViewModel = context.read<MqttPublishVm>();
    final DashboardViewmodel dashboardViewmodel = context
        .read<DashboardViewmodel>();
    // Tenta se conectar ao ligar o aplicativo
    final connected = await mqttConnection();
    if (connected) {
      // Increve-se nos tópicos necessários
      topicsInitialization(MqttServices());
      // Solicita as configurações
      mqttPublishViewModel.requestConfig();
      // Faz o processamento da mensagem recebida
      MqttServices().onMessageReceived = MqttMessageProcessor(
        devicesViewModel,
        mqttPublishViewModel,
        dashboardViewmodel,
      ).process;
    }
  }

  Future<bool> mqttConnection() async {
    final connected = await MqttServices().connect(
      broker: 'cebea07170a6456b831f1051f9f9ce47.s1.eu.hivemq.cloud',
      clientId: 'client_app',
      port: 8883,
    );
    return connected;
  }
}

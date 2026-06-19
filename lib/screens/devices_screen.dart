import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/services/mqtt/mqtt_connection.dart';
import 'package:virtual_display/services/mqtt/mqtt_message_processor.dart';
import 'package:virtual_display/services/mqtt/mqtt_publish.dart';
import 'package:virtual_display/services/mqtt/mqtt_services.dart';
import 'package:virtual_display/services/mqtt/topic_manager.dart';
import 'package:virtual_display/theme/widgets/app_bar_title_custom.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/viewModel/devices_viewmodel.dart';
import 'package:virtual_display/widgets/cards/cards_devices.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final MqttServices mqttServices = MqttServices();
  bool deviceStatus = false;

  Future<void> _connectMqtt() async {
    // Busca o valor no provider
    final devicesViewModel = context.read<DevicesViewModel>();
    // Tenta se conectar ao ligar o aplicativo
    final connected = await mqttConnection(mqttServices);
    if (connected) {
      // Faz o processamento da mensagem recebida
      mqttServices.onMessageReceived = MqttMessageProcessor(devicesViewModel).process;
      // Increve-se nos tópicos necessários
      topicsInitialization(mqttServices);
      // Solicita as configurações
      MqttPublish(mqttServices).requestDeviceName();
      setState(() {
        deviceStatus = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _connectMqtt();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationInitScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitleCustom(
            textScreen: AppLocalizations.of(context)!.devicesKnown,
          ),
        ),
        body: Column(
          children: [
            // Botão para nova conexão
            ElevatedButton.icon(
              icon: Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context)!.labelIconRefresh),
              onPressed: () {
                _connectMqtt();
              },
            ),
            // Cria os cards conforme detecta dispositivos conectados
            Expanded(
              child: Consumer<DevicesViewModel>(
                builder: (context, viewModel, child) {
                  log('Consumer usando VM: ${identityHashCode(viewModel)}');
                  return ListView.builder(
                    itemCount: viewModel.devices.length,
                    itemBuilder: (context, index) {
                      final deviceInfo = viewModel.devices[index];

                      return Column(
                        children: [
                          CardsDevices(
                            deviceName: deviceInfo.device,
                            deviceStatus: deviceInfo.online,
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

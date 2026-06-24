import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/credentials_broker.dart';
import 'package:virtual_display/viewModel/mqtt_connection_vm.dart';
import 'package:virtual_display/tests.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/widgets/show_material_banner.dart';

class CardsDevices extends StatefulWidget {
  final String deviceName;
  final bool deviceStatus;
  final CredentialsBroker credential;

  // Construtor
  const CardsDevices({
    super.key,
    required this.deviceName,
    required this.deviceStatus,
    required this.credential,
  });

  @override
  State<CardsDevices> createState() => _CardsDevicesState();
}

class _CardsDevicesState extends State<CardsDevices> {
  final Tests tests = Tests();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MqttConnectionVm mqttConnectionViewModel = context.watch<MqttConnectionVm>();
    return InkWell(
      onTap: () async {
        // Só tente se conectar se já não estiver conectado
        if (widget.deviceStatus == false) {
          // Tenta se conectar com o broker MQTT antes de trocar de tela
          final connected = await mqttConnectionViewModel.mqttConnection(
            context,
            widget.credential,
          );
          if (connected) {
            // Informa o usuário que se conectou
            if (context.mounted) {
              ShowBanner.messengerShow(
                context,
                AppLocalizations.of(context)!.successConnection,
                false,
              );
            }

            // Se a conexão for bem-sucedida, navega para a tela principal
            if (context.mounted) {
              Navigator.pushNamed(
                context,
                Constants.screenMain,
                arguments: {
                  'typeCard': tests.typeCard,
                  'idCard': tests.idCard,
                  'minValue': tests.minValue,
                  'maxValue': tests.maxValue,
                  'title': tests.title,
                  'value': tests.value,
                  'unit': tests.unit,
                },
              );
            }
          } else {
            // Se a conexão falhar, exibe uma mensagem de erro
            if (context.mounted) {
              ShowBanner.messengerShow(
                context,
                AppLocalizations.of(context)!.failConnectionMqtt,
                true,
              );
            }
          }
        } else {
          // Se já está conectado, vai direto para próxima tela
          Navigator.pushNamed(
            context,
            Constants.screenMain,
            arguments: {
              'deviceName': widget.deviceName,
              'deviceStatus': (widget.deviceStatus)
                  ? AppLocalizations.of(context)!.connected
                  : AppLocalizations.of(context)!.disconnected,
              'typeCard': tests.typeCard,
              'idCard': tests.idCard,
              'minValue': tests.minValue,
              'maxValue': tests.maxValue,
              'title': tests.title,
              'value': tests.value,
              'unit': tests.unit,
            },
          );
        }
      },
      child: Card(
        child: ListTile(
          title: Text(widget.deviceName),
          subtitle: Text(
            (widget.deviceStatus)
                ? AppLocalizations.of(context)!.connected
                : AppLocalizations.of(context)!.disconnected,
          ),
          leading: Icon(
            Icons.circle,
            color: widget.deviceStatus == true ? Colors.green : Colors.red,
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}

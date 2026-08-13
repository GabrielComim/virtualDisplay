import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/credentials_broker.dart';
import 'package:virtual_display/models/device_info.dart';
import 'package:virtual_display/viewModel/devices_viewmodel.dart';
import 'package:virtual_display/viewModel/mqtt_connection_vm.dart';
import 'package:virtual_display/tests.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/widgets/confirm_delete.dart';
import 'package:virtual_display/widgets/show_material_banner.dart';

class CardsDevices extends StatefulWidget {
  final String deviceName;
  final bool deviceStatus;
  final CredentialsBroker credential;
  final DevicesViewModel devicesViewModel;

  // Construtor
  const CardsDevices({
    super.key,
    required this.deviceName,
    required this.deviceStatus,
    required this.credential,
    required this.devicesViewModel,
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
    final MqttConnectionVm mqttConnectionViewModel = context
        .watch<MqttConnectionVm>();
    return InkWell(
      // Excluir dispositivo
      onLongPress: () async {
        final bool? confirmDelete = await showDialog<bool>(
          context: context,
          // Solicita confirmação antes de excluir
          builder: (context) => confirmDeleteDialog(context),
        );
        // Confirmado a exclusão, então faz ela
        if (confirmDelete == true) {
          // Remove o dispositivo da lista de dispositivos conhecidos
          widget.devicesViewModel.removeDevice(
            DeviceInfo(
              brokerId: widget.credential.id!,
              device: widget.deviceName,
              online: widget.deviceStatus,
            ),
          );
          ShowBanner.messengerShow(
            context,
            AppLocalizations.of(context)!.deviceRemoved,
            false,
          );
        }
      },
      onTap: () async {
        // Só tente se conectar se já não estiver conectado
        if (widget.deviceStatus == false) {
          // Tenta se conectar com o broker MQTT antes de trocar de tela
          final connected = await mqttConnectionViewModel.mqttConnection(
            context,
            widget.credential,
          );
          if (connected) {
            // Se a conexão for bem-sucedida, navega para a tela principal
            if (context.mounted) {
              Navigator.pushNamed(
                context,
                Constants.screenMain,
                arguments: {
                  'brokerId': widget.credential.id,
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
              'brokerId': widget.credential.id,
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

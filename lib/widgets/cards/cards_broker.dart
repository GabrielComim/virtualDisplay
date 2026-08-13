import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/credentials_broker.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/viewModel/mqtt_connection_vm.dart';
import 'package:virtual_display/widgets/show_material_banner.dart';

class CardsBroker extends StatefulWidget {
  final CredentialsBroker credentials;
  final VoidCallback onLongPress; // Retorna a função de clique longo
  final bool selectionMode; // Indica se está no modo de seleção
  final bool selected; // Item selecionado
  final ValueChanged<bool?> onSelected;

  // Construtor
  const CardsBroker({
    super.key,
    required this.credentials,
    required this.onLongPress,
    required this.selectionMode,
    required this.selected,
    required this.onSelected,
  });

  @override
  State<CardsBroker> createState() => _CardsBrokerState();
}

class _CardsBrokerState extends State<CardsBroker> {
  bool _brokerStatus = false;

  Future<bool> _connectMqtt(CredentialsBroker credential) async {
    return await MqttConnectionVm().initConnectMqtt(context, credential);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Verifica modo de seleção
        if (widget.selectionMode) {
          widget.onSelected(!widget.selected);
          return;
        }

        // Se está conectado, tenta desconectar
        if (_brokerStatus) {
          bool isDisconnected = await MqttConnectionVm().disconnectMqtt();
          if (isDisconnected) {
            setState(() {
              _brokerStatus = false;
            });
            ShowBanner.messengerShow(
              context,
              AppLocalizations.of(context)!.disconnected,
              false,
            );
            return;
          } else {
            ShowBanner.messengerShow(
              context,
              AppLocalizations.of(context)!.failDisconnectionMqtt,
              true,
            );
            return;
          }
        } else {}
        // Se está desconectado, tenta se conectar
        // Tenta se conectar ao broker
        bool isConnected = await _connectMqtt(widget.credentials);
        // Aguarda uns segundos para dar tempo de mostrar a mensagem de conexão com sucesso ou falha
        setState(() {
          _brokerStatus = isConnected;
        });

        if (isConnected) {
          ShowBanner.messengerShow(
            context,
            AppLocalizations.of(context)!.successConnection,
            false,
          );
          // Pequeno delay por causa da mensagem de sucesso ou falha
          if (context.mounted) {
            await Future.delayed(Duration(seconds: 2));
          }
          // Como conectou, navega para a tela de dispositivos
          if (context.mounted) {
            Navigator.pushNamed(
              context,
              Constants.screenDevices,
              arguments: {'credentialBroker': widget.credentials},
            );
          }
        } else {
          ShowBanner.messengerShow(
            context,
            AppLocalizations.of(context)!.failConnectionMqtt,
            true,
          );
        }
      },
      onLongPress: widget.onLongPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.selectionMode)
            Checkbox(
              activeColor: ColorScheme.of(context).secondary,
              value: widget.selected,
              onChanged: widget.onSelected,
            ),
          Expanded(
            child: Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context)!.mqttBroker,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                subtitle: Text(widget.credentials.broker),
                leading: Icon(
                  Icons.circle,
                  color: _brokerStatus ? Colors.green : Colors.red,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        ],
      ),
      // ElevatedButton.icon(label: Text(AppLocalizations.of(context)!.delete), onPressed: () {}, icon: Icon(Icons.delete)),
    );
  }
}

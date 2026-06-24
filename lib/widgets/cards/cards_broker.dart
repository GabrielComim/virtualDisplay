import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/credentials_broker.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/viewModel/mqtt_connection_vm.dart';

class CardsBroker extends StatefulWidget {
  final CredentialsBroker credentials;

  // Construtor
  const CardsBroker({super.key, required this.credentials});

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
        bool isConnected = await _connectMqtt(widget.credentials);
        setState(() {
          _brokerStatus = isConnected;
        });
        if(context.mounted){
          Navigator.pushNamed(context, Constants.screenDevices, arguments:{
            'credentialBroker': widget.credentials,
          } );
        }
      },
      child: Card(
        elevation: 5,
        child: ListTile(
          title: Text(
            AppLocalizations.of(context)!.mqttBroker,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          subtitle: Text(widget.credentials.broker),
          leading: Icon(Icons.circle, color: _brokerStatus ? Colors.green : Colors.red), 
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}

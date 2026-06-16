import 'package:flutter/material.dart';
import 'package:virtual_display/services/mqtt_services.dart';
import 'package:virtual_display/tests.dart';
import 'package:virtual_display/utils/constants.dart';

class CardsDevices extends StatefulWidget {
  final String deviceName;
  final String deviceStatus;

  // Construtor
  const CardsDevices({
    super.key,
    required this.deviceName,
    required this.deviceStatus,
  });

  @override
  State<CardsDevices> createState() => _CardsDevicesState();
}

class _CardsDevicesState extends State<CardsDevices> {
  final Tests tests = Tests();
  final MqttServices mqttServices = MqttServices();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Tenta se conectar com o broker MQTT antes de trocar de tela
        final connected = await mqttServices.connect(
          broker: 'cebea07170a6456b831f1051f9f9ce47.s1.eu.hivemq.cloud',
          clientId: 'client_app',
          port: 8883,
        );
        if (connected) {
          // Publicação de teste
          mqttServices.publish(
            Constants.mqttTopicTest, 
            '''
            {
              "device":"Flutter",
              "msg":"Conectado"
            }
            '''
          );
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Falha ao conectar ao broker MQTT')),
            );
          }
        }
      },
      child: Card(
        child: ListTile(
          title: Text(widget.deviceName),
          subtitle: Text(widget.deviceStatus),
          leading: Icon(
            Icons.circle,
            color: widget.deviceStatus == 'Conectado'
                ? Colors.green
                : Colors.red,
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}

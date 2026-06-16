import 'package:virtual_display/services/mqtt/mqtt_services.dart';

Future<bool> mqttConnection(MqttServices mqttServices) async {
  final connected =  await mqttServices.connect(
    broker: 'cebea07170a6456b831f1051f9f9ce47.s1.eu.hivemq.cloud',
    clientId: 'client_app',
    port: 8883,
  );
  return connected;
}

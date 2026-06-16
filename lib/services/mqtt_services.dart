import 'dart:developer';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:virtual_display/utils/constants.dart';

// Protocolo MQTT funcionando com o broker HIVEMQ
class MqttServices {
  static final MqttServices _instance = MqttServices._internal();

  factory MqttServices() {
    return _instance;
  }
  MqttServices._internal();

  late MqttServerClient client;

  Function(String topic, String payload)? onMessageReceived;

  Future<bool> connect({
    required String broker,
    required String clientId,
    required int port,
  }) async {
    client = MqttServerClient(broker, clientId);
    client.port = port;
    // client.setProtocolV311();
    client.secure = true;
    client.keepAlivePeriod = 20;
    client.logging(on: true);
    try {
      client.connectionMessage = MqttConnectMessage()
          .authenticateAs(
            Constants.mqttCredentialsName,
            Constants.mqttCredentialsPassword,
          )
          .startClean();
      await client.connect();

      // Registra o listener para receber dados publicados
      client.updates?.listen(_onMessage);

      log(client.connectionStatus?.state.toString() ?? 'No connection status');
      return true;
    } catch (_) {
      client.disconnect();
      return false;
    }
  }

  // Método para publicar uma mensagem em um tópico MQTT
  void publish(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }
  
  // Método para se inscrever em um tópico MQTT
  Future<void> subscribe(String topic) async {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  // Callback para recebimento das mensagens MQTT
  void _onMessage(List<MqttReceivedMessage<MqttMessage>> events) {
    final recMess = events[0].payload as MqttPublishMessage;
    final payload = MqttPublishPayload.bytesToStringAsString(
      recMess.payload.message,
    );

    final topic = events[0].topic;
    log('Topic: $topic');
    log('Payload: $payload');
    onMessageReceived?.call(topic, payload);
  }
}

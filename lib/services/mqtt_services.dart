import 'dart:async';
import 'dart:developer';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// Protocolo MQTT funcionando com o broker HIVEMQ
class MqttServices {
  static final MqttServices _instance = MqttServices._internal();

  factory MqttServices() {
    return _instance;
  }
  MqttServices._internal();

  MqttServerClient? client;

  Function(String topic, String payload)? onMessageReceived;

  // Guardar o subscription para conseguir cancelar o listener quando desconectado.
  StreamSubscription? _subscription;

  Future<bool> connect({
    required String broker,
    required String clientId,
    required int port,
    required bool tls,
    String? credentialName,
    String? credentialPassword,
  }) async {
    // Desconecta o cliente mqtt anterior antes de criar um novo
    await disconnect();

    final mqttClient = MqttServerClient(broker, clientId);
    mqttClient.port = port;
    mqttClient.secure = tls;
    mqttClient.keepAlivePeriod = 20;
    mqttClient.logging(on: true);

    client = mqttClient;
    try {
      final message = MqttConnectMessage().startClean();
      if ((credentialName?.isNotEmpty ?? false)) {
        message.authenticateAs(credentialName, credentialPassword ?? '');
      }
      client!.connectionMessage = message;

      // Tenta conectar-se ao broker
      await client!.connect();
      // Confere se conectou com sucesso
      if(client!.connectionStatus?.state != MqttConnectionState.connected) {
        return false;
      }

      // Registra o listener para receber dados publicados
      if(client!.updates != null) {
        _subscription = client!.updates?.listen(_onMessage);
        log('Listener mqtt registrado');
      } else {
        log('ERRO: updates mqtt é null');
      }

      return true;
    } catch (_) {
      client!.disconnect();
      return false;
    }
  }

  // Método para publicar uma mensagem em um tópico MQTT
  void publish(String topic, String message) {
    // Verifica se está conectado antes de publicar
    if (client!.connectionStatus?.state != MqttConnectionState.connected) {
      log('CLIENTE DESCONECTADO. NÃO PODE PUBLICAR MENSAGEM');
      return;
    }
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client!.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  // Método para se inscrever em um tópico MQTT
  Future<void> subscribe(String topic) async {
    if (client!.connectionStatus?.state != MqttConnectionState.connected) {
      log('Não inscrito. Mqtt desconectado');
      return;
    }
    client!.subscribe(topic, MqttQos.atLeastOnce);
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

  Future<bool> disconnect() async {
    try {
      // Cancela sempre o listener existente
      await _subscription?.cancel();
      _subscription = null;

      // Só tenta desconectar se realmente existe uma conexão ativa
      if (client != null &&
          client!.connectionStatus?.state == MqttConnectionState.connected) {
        client!.disconnect();
        log('MQTT desconectado com sucesso');
        return true;
      }
      client = null;
      return false;
    } catch (e) {
      log('Erro ao desconectar MQTT: $e');
      return false;
    }
  }
}

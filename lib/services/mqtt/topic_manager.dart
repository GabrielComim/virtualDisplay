import 'package:virtual_display/services/mqtt_services.dart';
import 'package:virtual_display/utils/constants.dart';

void topicsInitialization(MqttServices mqttService) {
  mqttService.subscribe(Constants.mqttTopicTest);
  mqttService.subscribe(Constants.mqttTopicResponseConfig);
  mqttService.subscribe(Constants.mqttTopicRequestConfig);
  mqttService.subscribe(Constants.mqttTopicConfigAck);
  mqttService.subscribe(Constants.mqttTopicData);
  mqttService.subscribe(Constants.mqttTopicResponseDevice);
}
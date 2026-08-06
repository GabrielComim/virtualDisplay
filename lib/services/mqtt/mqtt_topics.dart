import 'package:virtual_display/utils/constants.dart';

class MqttTopics {
  static String config() {
    return '${Constants.baseTopic}${Constants.mqttTopicResponseConfig}';
  }
  
  static String configAck() {
    return '${Constants.baseTopic}${Constants.mqttTopicConfigAck}';
  }

  static String data(String deviceName) {
    return '${Constants.baseTopic}/$deviceName${Constants.mqttTopicData}';
  }

  static String button(String deviceName) {
    return '${Constants.baseTopic}/$deviceName${Constants.mqttTopicButton}';
  }
}
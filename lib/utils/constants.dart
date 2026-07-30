class Constants {
  // Nome das telas e modais
  static const String screenBroker = '/broker';
  static const String screenDevices = '/devices';
  static const String screenMain = '/main';
  static const String screenProtocol = '/protocol';
  static const String screenModalConnection = '/modal_connection';
  static const String screenExportCSV = '/export_CSV';
  static const String screenAutomations = '/automation';
  static const String screenHelpInitial = '/help';

  // Tipos de cards 
  static const String cardTypeNumber = 'number';
  static const String cardTypeBool = 'bool';
  static const String cardTypeString = 'string';

  // IDs de cards para o dashboard
  static const String cardIdSpeed = 'speed';
  static const String cardIdTemperature = 'temperature';
  static const String cardIdHumidity = 'humidity';
  static const String cardIdVoltage = 'voltage';
  static const String cardIdCurrent = 'current';
  static const String cardIdPressure = 'pressure';
  static const String cardIdMagnetic = 'magnetic';
  static const String cardIdLevel = 'level';
  static const String cardIdDetector = 'detector';
  static const String cardIdWeight = 'weight';
  static const String cardIdOther = 'other';
  // IDs de cards para o dashboard booleano
  static const String cardIdGPS = 'gps';
  static const String cardIdLed = 'led';
  static const String cardIdBuzzer = 'buzzer';
  static const String cardIdAlarm = 'alarm';
  // IDs de cards para mensagens de texto
  static const String cardIdMessage = 'message';

  // Diretório dos ícones fora do padrão do materialApp
  static const String iconSpeed = 'assets/icons/icon_speed.png';
  static const String iconTemperature = 'assets/icons/icon_temperature.png';
  static const String iconHumidity = 'assets/icons/icon_humidity.png';
  static const String iconVoltage = 'assets/icons/icon_voltage.png';
  static const String iconCurrent = 'assets/icons/icon_current.png';
  static const String iconPressure = 'assets/icons/icon_pressure.png';
  static const String iconMagnetic = 'assets/icons/icon_magnetic.png';
  static const String iconLevel = 'assets/icons/icon_level.png';
  static const String iconDetector = 'assets/icons/icon_detector.png';
  static const String iconWeight = 'assets/icons/icon_weight.png';
  static const String iconOther = 'assets/icons/icon_other.png';
  static const String iconLocalization = 'assets/icons/icon_localization.png';
  static const String iconLed = 'assets/icons/icon_led.png';
  static const String iconBuzzer = 'assets/icons/icon_buzzer.png';
  static const String iconAlarm = 'assets/icons/icon_alarm.png';
  static const String iconButton = 'assets/icons/icon_button.png';
  static const String iconOn = 'assets/icons/icon_on.png';
  static const String iconOff = 'assets/icons/icon_off.png';

  // Tipos de textos
  static const String titleText1 =    'text1';
  static const String titleText2 =    'text2';
  static const String titleText3 =    'text3';
  static const String titleText4 =    'text4';
  static const String subtitleText1 = 'text5';
  static const String subtitleText2 = 'text6';
  static const String subtitleText3 = 'text7';
  static const String bodyText1 =     'text8';
  static const String bodyText2 =     'text9';
  static const String bodyText3 =     'text10';
  static const String bodyText4 =     'text11';
  static const String bodyText5 =     'text12';
  static const String bodyText6 =     'text13';

  // Tópicos MQTT
  static const String mqttTopicData =           'virtualDisplay/data';
  static const String mqttTopicRequestConfig =  'virtualDisplay/request_config';
  static const String mqttTopicResponseConfig = 'virtualDisplay/response_config';
  static const String mqttTopicConfigAck =      'virtualDisplay/config_ack';
  static const String mqttTopicButton =         'virtualDisplay/button/';

  // Usado para lógica de comparação
  static const String topicData = '/data';
  static const String topicButton = 'virtualDisplay/button/#';
  static const String topicRequestConfig = '/request_config';
  static const String topicConfigAck = '/config_ack';
  static const String topicRequestDevice = '/request_device';
  static const String topicResponseDevice = '/response_device';
  static const String topicResponseConfig = '/response_config';


  static const String automationOneShot = 'oneShot';
  static const String automationPeriodic = 'periodic';
  static const String automationLogical = 'logical';
  // Tipos de automações
  static const List<String> typeAutomations = [
    '',
    automationOneShot,
    automationPeriodic,
    automationLogical,
  ];

  static const String actionPublish = 'publish';
   // Tipos de ação
  static const List<String> actionAutomations = [
    '',
    actionPublish,
  ];

  static const String automationInterval1Minute = '1 minute';
  static const String automationInterval5Minutes = '5 minutes';
  static const String automationInterval10Minutes = '10 minutes';
  static const String automationInterval15Minutes = '15 minutes';
  static const String automationInterval30Minutes = '30 minutes';
  static const String automationInterval1Hour = '1 hour';
  static const String automationInterval2Hours = '2 hours';
  static const String automationInterval6Hours = '6 hours';
  static const String automationInterval12Hours = '12 hours';
  static const String automationInterval1Day = '1 day';
  static const String automationInterval2Days = '2 days';
  static const String automationInterval1Week = '1 week';
  static const String automationInterval1Month = '1 month';

  static const List<String> periodicIntervals = [
    automationInterval1Minute,
    automationInterval5Minutes,
    automationInterval10Minutes,
    automationInterval15Minutes,
    automationInterval30Minutes,
    automationInterval1Hour,
    automationInterval2Hours,
    automationInterval6Hours,
    automationInterval12Hours,
    automationInterval1Day,
    automationInterval2Days,
    automationInterval1Week,
    automationInterval1Month,
  ];

  static const String logicalConditionAnd = '&';
  static const String logicalConditionNot = '!';
  static const String logicalConditionEqual = '=';
  static const String logicalConditionMinor = '<';
  static const String logicalConditionMinorEqual = '<=';
  static const String logicalConditionMajor = '>';
  static const String logicalConditionMajorEqual = '>=';
  
  static const List<String> logicalConditions = [
    logicalConditionAnd,
    logicalConditionNot,
    logicalConditionEqual,
    logicalConditionMinor,
    logicalConditionMinorEqual,
    logicalConditionMajor,
    logicalConditionMajorEqual,
  ];

  static const String left = 'left';
  static const String right = 'right';
}
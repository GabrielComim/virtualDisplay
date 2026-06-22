import 'package:virtual_display/utils/constants.dart';

class Tests {
  List<String> typeCard = [
    Constants.cardTypeNumber,
    Constants.cardTypeNumber,
    Constants.cardTypeNumber,
    Constants.cardTypeNumber,
    Constants.cardTypeNumber,
    Constants.cardTypeNumber,
    Constants.cardTypeNumber,
    Constants.cardTypeNumber,
    Constants.cardTypeNumber,
    Constants.cardTypeNumber,
    Constants.cardTypeBool,
    Constants.cardTypeString,
  ]; // Exemplo de tipos de cards a serem exibidos no dashboard
  List<String> idCard = [
    Constants.cardIdSpeed,
    Constants.cardIdTemperature,
    Constants.cardIdHumidity,
    Constants.cardIdVoltage,
    Constants.cardIdCurrent,
    Constants.cardIdPressure,
    Constants.cardIdMagnetic,
    Constants.cardIdLevel,
    Constants.cardIdDetector,
    Constants.cardIdWeight,
    Constants.cardIdGPS,
    Constants.cardIdMessage,
  ]; // Exemplo de tipos de cards a serem exibidos no dashboard
  List<int> minValue = [0, -40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // Valores mínimos para cada card
  List<int> maxValue = [240, 85, 100, 24, 100, 100, 100, 100, 100, 100, 100, 100]; // Valores máximos para cada card
  List<String> title = [
    'Velocidade',
    'Temperatura',
    'Umidade',
    'Tensão',
    'Corrente',
    'Pressão',
    'Campo Magnético',
    'Nível de Líquido',
    'Detector de Movimento',
    'Peso',
    'GPS',
    'Mensagem de Alerta'
  ]; // Títulos para cada card
  List<String> value = [
    '120',
    '25',
    '60',
    '12',
    '5',
    '1013',
    '0',
    '50',
    '0',
    '10',
    '1',
    'Alerta: Temperatura Alta'
  ]; // Valores a serem exibidos em cada card
  List<String> unit = [
    'km/h',
    '°C',
    '%',
    'V',
    'A',
    'hPa',
    'µT',
    '%',
    '',
    'kg',
    '',
    ''
  ]; // Unidades para cada card
}

// JSON para teste
/**
 * {
  "device":"ESP32",
  "widgets": [
    {
      "id": "temperature",
      "type": "number",
      "title": "Sensor temp.",
      "decimal": "2",
      "unit": "°C",
      "min": "-55.0",
      "max": "200",
      "history": "true",
      "value":"10"
    },
    {
      "id": "speed",
      "type": "number",
      "title": "Veloc.",
      "decimal": "1",
      "unit": "RPM",
      "min": "0",
      "max": "200",
      "history": "true",
      "value":"95"
    },
    {
      "id": "led",
      "type": "bool",
      "title": "Lamp. 1",
      "value":"true"
    },
    {
      "id": "gps",
      "type": "bool",
      "title": "Lamp. 2",
      "value":"false"
    },
    {
      "id": "message",
      "type": "string",
      "title": "Alertas",
      "value":"Erro na comunicação"
    }
  ],
 "device":"STM32",
  "widgets": [
    {
      "id": "temperature",
      "type": "number",
      "title": "Sensor temp.",
      "decimal": "1",
      "unit": "°C",
      "min": "-55.0",
      "max": "200",
      "history": "true",
      "value":"10"
    },
    {
      "id": "speed",
      "type": "number",
      "title": "Veloc.",
      "decimal": "1",
      "unit": "RPM",
      "min": "0",
      "max": "200",
      "history": "true",
      "value":"95"
    },
    {
      "id": "led",
      "type": "bool",
      "title": "Lamp. 1",
      "value":"true"
    },
    {
      "id": "gps",
      "type": "bool",
      "title": "Lamp. 2",
      "value":"false"
    },
    {
      "id": "message",
      "type": "string",
      "title": "Alertas",
      "value":"Erro na comunicação"
    }
  ]
}


{
  "values": {
    "Sensor temp.": "60.45",
    "Lamp. 2": true,
    "Veloc.":"91",
   "Alertas":"Erro não identificado"
  }
}
 */
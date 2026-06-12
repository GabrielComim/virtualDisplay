import 'package:flutter/material.dart';
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
  // TODO: Substituir por dados reais do dispositivo selecionado
  List<String> typeCard = [
    Constants.cardTypeSpeed,
    Constants.cardTypeTemperature,
    Constants.cardTypeHumidity,
    Constants.cardTypeVoltage,
    Constants.cardTypeCurrent,
    Constants.cardTypePressure,
    Constants.cardTypeMagnetic,
    Constants.cardTypeLevel,
    Constants.cardTypeDetector,
    Constants.cardTypeWeight,
  ]; // Exemplo de tipos de cards a serem exibidos no dashboard
  List<int> minValue = [0, -40, 0, 0, 0, 0, 0, 0, 0, 0]; // Valores mínimos para cada card
  List<int> maxValue = [240, 85, 100, 24, 100, 100, 100, 100, 100, 100]; // Valores máximos para cada card

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Constants.screenMain,
          arguments: {
            'typeCard': typeCard,
            'minValue': minValue,
            'maxValue': maxValue,
          },
        );
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

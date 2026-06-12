import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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

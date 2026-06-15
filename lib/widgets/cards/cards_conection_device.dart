import 'package:flutter/material.dart';
import 'package:virtual_display/theme/colors.dart';

class CardsConectionDevice extends StatefulWidget {
  final String deviceName;
  final String deviceStatus;
  // Construtor
  const CardsConectionDevice({super.key, required this.deviceName, required this.deviceStatus});

  @override
  State<CardsConectionDevice> createState() => _CardsConectionDeviceState();
}

class _CardsConectionDeviceState extends State<CardsConectionDevice> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.outline, width: 1),
      ),
      color: AppColors.cardConnectionBackground,
      child: ListTile(
        title: Text(widget.deviceName),
        subtitle: Text(widget.deviceStatus),
        leading: Icon(Icons.circle, color: widget.deviceStatus == 'Conectado' ? Colors.green : Colors.red), 
      ),
    );
  }
}
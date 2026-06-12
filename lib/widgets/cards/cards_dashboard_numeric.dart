import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/utils/constants.dart';

class CardsDashboardNumeric extends StatefulWidget {
  final String type;
  final int value;
  final String unit;
  final int? min;
  final int? max;

  // Construtor
  const CardsDashboardNumeric({
    super.key,
    required this.type,
    required this.value,
    required this.unit,
    this.min,
    this.max,
  });

  @override
  State<CardsDashboardNumeric> createState() => _CardsDashboardNumericState();
}

Widget _typeCardDashboardNumeric(BuildContext context, String type, int value) {
  switch (type) {
    // CARD DE VELOCIDADE
    case Constants.cardTypeSpeed:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Constants.iconSpeed, width: 50, height: 50),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.speed,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    // CARD DE TEMPERATURA
    case Constants.cardTypeTemperature:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Constants.iconTemperature, width: 50, height: 50),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.temperature,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    // CARD DE UMIDADE
    case Constants.cardTypeHumidity:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Constants.iconHumidity, width: 50, height: 50),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.humidity,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    // CARD DE VOLTAGE
    case Constants.cardTypeVoltage:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Constants.iconVoltage, width: 50, height: 50),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.voltage,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    // CARD DE CORRENTE ELÉTRICA
    case Constants.cardTypeCurrent:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Constants.iconCurrent, width: 50, height: 50),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.current,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    // CARD DE PRESSÃO
    case Constants.cardTypePressure:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Constants.iconPressure, width: 50, height: 50),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.pressure,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    // CARD DE SENSOR MAGNÉTICO
    case Constants.cardTypeMagnetic:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Constants.iconMagnetic, width: 50, height: 50),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.magnetic,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    // CARD DE NÍVEL
    case Constants.cardTypeLevel:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Constants.iconLevel, width: 50, height: 50),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.level,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    // CARD DE DETECÇÃO
    case Constants.cardTypeDetector:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Constants.iconDetector, width: 50, height: 50),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.detector,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    // CARD DE Peso
    case Constants.cardTypeWeight:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Constants.iconWeight, width: 50, height: 50),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.weight,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    default:
      // Configurações padrão
      return Text('Tipo de card não reconhecido');
  }
}

class _CardsDashboardNumericState extends State<CardsDashboardNumeric> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _typeCardDashboardNumeric(context, widget.type, widget.value),
            Text(
              '${widget.value} ${widget.unit}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 8),
            Text(
              widget.min != null ? 'Min: ${widget.min} ${widget.unit}' : '',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
            Text(
              widget.max != null ? 'Max: ${widget.max} ${widget.unit}' : '',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

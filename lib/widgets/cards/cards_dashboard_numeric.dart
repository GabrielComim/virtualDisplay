import 'package:flutter/material.dart';
import 'package:virtual_display/utils/constants.dart';

class CardsDashboardNumeric extends StatefulWidget {
  final String title;
  final String id;
  final double value;
  final String? unit;
  final String? decimal;
  final int? min;
  final int? max;

  // Construtor
  const CardsDashboardNumeric({
    super.key,
    required this.title,
    required this.id,
    required this.value,
    this.unit,
    this.decimal,
    this.min,
    this.max,
  });

  @override
  State<CardsDashboardNumeric> createState() => _CardsDashboardNumericState();
}

Widget _typeCardDashboardNumeric(BuildContext context, String id, double value) {
  switch (id) {
    // CARD DE VELOCIDADE
    case Constants.cardIdSpeed:
      return Image.asset(Constants.iconSpeed, width: 50, height: 50);
    // CARD DE TEMPERATURA
    case Constants.cardIdTemperature:
      return Image.asset(Constants.iconTemperature, width: 50, height: 50);
    // CARD DE UMIDADE
    case Constants.cardIdHumidity:
      return Image.asset(Constants.iconHumidity, width: 50, height: 50);
    // CARD DE VOLTAGE
    case Constants.cardIdVoltage:
      return Image.asset(Constants.iconVoltage, width: 50, height: 50);
         
    // CARD DE CORRENTE ELÉTRICA
    case Constants.cardIdCurrent:
      return Image.asset(Constants.iconCurrent, width: 50, height: 50);
    // CARD DE PRESSÃO
    case Constants.cardIdPressure:
      return Image.asset(Constants.iconPressure, width: 50, height: 50);
    // CARD DE SENSOR MAGNÉTICO
    case Constants.cardIdMagnetic:
      return Image.asset(Constants.iconMagnetic, width: 50, height: 50);
    // CARD DE NÍVEL
    case Constants.cardIdLevel:
      return Image.asset(Constants.iconLevel, width: 50, height: 50);
    // CARD DE DETECÇÃO
    case Constants.cardIdDetector:
      return Image.asset(Constants.iconDetector, width: 50, height: 50);
    // CARD DE Peso
    case Constants.cardIdWeight:
      return Image.asset(Constants.iconWeight, width: 50, height: 50);
    // CARD DE Outros tipos não especificados
    case Constants.cardIdOther:
      return Image.asset(Constants.iconOther, width: 50, height: 50);
    default:
      // Configurações padrão
      return Text('Tipo de card não reconhecido: NUMBER');
  }
}

class _CardsDashboardNumericState extends State<CardsDashboardNumeric> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _typeCardDashboardNumeric(context, widget.id, widget.value),
            SizedBox(height: 8),
            Text(
              widget.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${(widget.value).toStringAsFixed(int.parse(widget.decimal ?? '0'))} ${widget.unit ?? ''}',
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

import 'package:flutter/material.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/widgets/circle_status.dart';

class CardsDashboardBool extends StatefulWidget {
  final String title;
  final String id;
  final bool value;

  // Construtor
  const CardsDashboardBool({
    super.key,
    required this.title,
    required this.id,
    required this.value,
  });

  @override
  State<CardsDashboardBool> createState() => _CardsDashboardBoolState();
}

class _CardsDashboardBoolState extends State<CardsDashboardBool> {
  Widget _typeCardDashboardBool(BuildContext context, String id) {
    switch (id) {
      // CARD DE GPS
      case Constants.cardIdGPS:
        return Image.asset(Constants.iconLocalization, width: 50, height: 50);
      // CARD DE LED
      case Constants.cardIdLed:
        return Image.asset(Constants.iconLed, width: 50, height: 50);
      case Constants.cardIdBuzzer:
        return Image.asset(Constants.iconBuzzer, width: 50, height: 50);
      case Constants.cardIdAlarm:
        return Image.asset(Constants.iconAlarm, width: 50, height: 50);
      default:
        return Text('Tipo de card não reconhecido');
    }
  }

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
          children: [
            _typeCardDashboardBool(context, widget.id),
            SizedBox(height: 8),
            Row(
              children: [
                // Indicador de status (verde para ativo, vermelho para inativo)
                circleStatus(widget.value),
                SizedBox(width: 12),
                // Título do card
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:virtual_display/utils/constants.dart';

class CardsDashboardString extends StatefulWidget {
  final String title;
  final String id;
  final String msg;

  // Construtor
  const CardsDashboardString({
    super.key,
    required this.title,
    required this.id,
    required this.msg,
  });

  @override
  State<CardsDashboardString> createState() => _CardsDashboardStringState();
}

class _CardsDashboardStringState extends State<CardsDashboardString> {
  Widget _typeCardString(String title, String id) {
    switch (id) {
      case Constants.cardIdMessage:
        return Row(
          children: [
            Image.asset(Constants.iconAlarm, height: 50, width: 50),
            SizedBox(width: 10),
            Flexible(
              child: Column(
                children: [
                  Text(title, style: TextStyle(fontSize: 20)),
                  // TODO: Definir se será necessário o timestamp
                  // SizedBox(height: 4),
                  // Text('Timestamp: $timestamp'),
                ],
              ),
            ),
          ],
        );
      default:
        return Text('Tipo de Card não identificado!');
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
          mainAxisSize: MainAxisSize.min,
          children: [
            _typeCardString(widget.title, widget.id),
            SizedBox(height: 8),
            Text(widget.msg),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/action/action_publish.dart';

Widget actionConfigMode(
  BuildContext context,
  ActionConfig? action, {
  required DateTime? selectedDateTime,
  required ValueChanged<ActionConfig> onChanged,
}) {
  if (action is PublishAction) {
    return Column(
      children: [
        // TOPIC
        TextFormField(
          cursorColor: ColorScheme.of(context).secondary,
          initialValue: action.topic,
          decoration: InputDecoration(
            labelText: 'Topic',
            labelStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          onChanged: (value) {
            onChanged(action.copyWith(topic: value));
          },
        ),
        SizedBox(height: 10),
        // PAYLOAD
        TextFormField(
          cursorColor: ColorScheme.of(context).secondary,
          initialValue: action.payload,
          decoration: InputDecoration(
            labelText: 'Payload',
            labelStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          // inputFormatters: [
          //   // Permite apenas números
          //   FilteringTextInputFormatter.allow(RegExp(r'[012]')),      // Teclado com apenas 0, 1 e 2
          //   LengthLimitingTextInputFormatter(1),                      // Limita a 1 dígito
          // ],
          onChanged: (value) {
            onChanged(action.copyWith(payload: value));
          },
        ),
        SizedBox(height: 10),
        // QoS
        DropdownButtonFormField<int>(
          decoration: InputDecoration(
            labelText: 'QoS',
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ColorScheme.of(context).outlineVariant,
            ),
            border: OutlineInputBorder(),
          ),
          items: [
            DropdownMenuItem(value: 0, child: Text('0')),
            DropdownMenuItem(value: 1, child: Text('1')),
            DropdownMenuItem(value: 2, child: Text('2')),
          ],
          onChanged: (value) {
            if (value != null) {
              onChanged(action.copyWith(qos: value));
            }
          },
        ),
        SizedBox(height: 10),
        // RETAIN
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.retain,
              style: TextStyle(
                color: ColorScheme.of(context).secondary,
                fontSize: 13,
              ),
            ),
            SizedBox(width: 4),
            Checkbox(
              activeColor: ColorScheme.of(context).secondary,
              onChanged: (value) {
                onChanged(action.copyWith(retain: value));
              },
              value: action.retain,
            ),
          ],
        ),
      ],
    );
  } else {
    return SizedBox.shrink();
  }
}

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
          initialValue: action.payload,
          decoration: InputDecoration(
            labelText: 'Payload',
            labelStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          onChanged: (value) {
            onChanged(action.copyWith(payload: value));
          },
        ),
        SizedBox(height: 10),
        // QoS
        TextFormField(
          initialValue: action.qos.toString(),
          decoration: InputDecoration(
            labelText: 'QoS',
            labelStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            onChanged(action.copyWith(qos: int.parse(value)));
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

import 'package:flutter/material.dart';
import 'package:virtual_display/models/action/action_publish.dart';

Widget actionConfigMode(
  BuildContext context,
  ActionConfig? action, {
  required DateTime? selectedDateTime,
  required ValueChanged<ActionConfig> onChanged,
}) {
  if(action is PublishAction) {
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
      ],
    );
  } else {
    return SizedBox.shrink();
  }
}
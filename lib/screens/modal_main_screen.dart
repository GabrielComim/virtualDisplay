import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';

Future<void> modalMainScreen(BuildContext context) {
  return showModalBottomSheet(
            context: context,
            useSafeArea: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return SafeArea(
                child: Container(
                  // Campo para alterar o broker MQTT
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.configAdvanced,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.mqttBroker,
                          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorScheme.of(context).secondary,
                          ),
                          hintText: '${AppLocalizations.of(context)!.example}: mqtt://broker.hivemq.com:1883',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para salvar o novo broker MQTT
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.ok),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
}
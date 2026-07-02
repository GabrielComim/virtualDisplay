import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/trigger/trigger_config.dart';
import 'package:virtual_display/utils/constants.dart';

Widget triggerConfigMode(
  BuildContext context,
  String type,
  TriggerConfig? trigger, {
  required DateTime? selectedDateTime,
  required ValueChanged<DateTime> onChanged,
}) {
  switch (type) {
    case Constants.automationOneShot:
      // Data e hora
      return oneShotTriggerConfigWidget(
        context,
        trigger: trigger,
        selectedDateTime: selectedDateTime,
        onChanged: onChanged,
      );
    case Constants.automationPeriodic:
      // Recorrência + data e hora
      return periodicTriggerConfigWidget(context, trigger: trigger);
    case Constants.automationLogical:
      // Lógica + (data e hora) não obrigatório
      return logicalTriggerConfigWidget(context, trigger: trigger);
    default:
      return SizedBox.shrink();
  }
}

// Mostra os campos de data e hora para o usuário preencher, caso o tipo de trigger seja "one shot"
Widget oneShotTriggerConfigWidget(
  BuildContext context, {
  required TriggerConfig? trigger,
  required DateTime? selectedDateTime,
  required ValueChanged<DateTime> onChanged,
}) {
  return Column(
    children: [
      // Botão para selecionar data
      Card(
        child: ListTile(
          tileColor: ColorScheme.of(context).secondary.withAlpha(50),
          title: Text(
            trigger is OneshotTrigger
                ? trigger.dateTime.toLocal().toString()
                : AppLocalizations.of(context)!.dateAndHour,
          ),
          subtitle: Text(
            selectedDateTime != null
                ? DateFormat('dd/MM/yyyy HH:mm').format(selectedDateTime)
                : '',
          ),
          trailing: Icon(Icons.calendar_today),
          onTap: () async {
            // DATA
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: Theme.of(
                        context,
                      ).colorScheme.secondary, // Cabeçalho e data selecionada
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSurface, // CANCELAR e OK
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            // HORA
            if (pickedDate != null && context.mounted) {
              final pickedTime = await showTimePicker(
                context: context,
                initialTime: trigger is OneshotTrigger
                    ? TimeOfDay.fromDateTime(trigger.dateTime)
                    : TimeOfDay.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Theme.of(
                          context,
                        ).colorScheme.secondary, // Cabeçalho e data selecionada
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onSurface, // CANCELAR e OK
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (pickedTime != null) {
                final newDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );

                onChanged(newDateTime);
              }
            }
          },
        ),
      ),
    ],
  );
}

// Mostra os campos de recorrência edata e hora para o usuário preencher, caso o tipo de trigger seja "periodic"
Widget periodicTriggerConfigWidget(
  BuildContext context, {
  required TriggerConfig? trigger,
}) {
  return Column(children: [Text('Data de início:'), Text('Intervalo:')]);
}

// Mostra os campos de lógica e data e hora para o usuário preencher, caso o tipo de trigger seja "logical"
Widget logicalTriggerConfigWidget(
  BuildContext context, {
  required TriggerConfig? trigger,
}) {
  return Column(children: [Text('Lógica:')]);
}

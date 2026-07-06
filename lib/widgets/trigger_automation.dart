import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/trigger/trigger_config.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/utils/switch_menu_item.dart';

Widget triggerConfigMode(
  BuildContext context,
  String type,
  TriggerConfig? trigger, {
  required DateTime? selectedDateTime,
  required ValueChanged<TriggerConfig> onChanged,
}) {
  switch (type) {
    case Constants.automationOneShot:
      // Data e hora
      return oneShotTriggerConfigWidget(
        context,
        trigger: trigger,
        onChanged: onChanged,
      );
    case Constants.automationPeriodic:
      // Recorrência + data e hora
      return periodicTriggerConfigWidget(
        context,
        trigger,
        onChanged: onChanged,
      );
    case Constants.automationLogical:
      // Lógica + (data e hora) não obrigatório
      return logicalTriggerConfigWidget(context, trigger, onChanged: onChanged);
    default:
      return SizedBox.shrink();
  }
}

// ===========================================================================================================
// Mostra os campos de data e hora para o usuário preencher, caso o tipo de trigger seja "one shot"
Widget oneShotTriggerConfigWidget(
  BuildContext context, {
  required TriggerConfig? trigger,
  required ValueChanged<TriggerConfig> onChanged,
}) {
  return Column(
    children: [
      // Botão para selecionar data
      Card(
        child: ListTile(
          tileColor: ColorScheme.of(context).secondary.withAlpha(50),
          title: Text(AppLocalizations.of(context)!.dateAndHour),
          subtitle: Text(
            trigger is OneshotTrigger
                ? DateFormat('dd/MM/yyyy HH:mm').format(trigger.dateTime)
                : '',
          ),
          trailing: Icon(Icons.calendar_today),
          onTap: () async {
            final newDateTime = await dateAndHour(context, trigger);
            if (trigger is OneshotTrigger) {
              onChanged(trigger.copyWith(dateTime: newDateTime));
            }
          },
        ),
      ),
    ],
  );
}

// ===========================================================================================================
// Mostra os campos de recorrência edata e hora para o usuário preencher, caso o tipo de trigger seja "periodic"
Widget periodicTriggerConfigWidget(
  BuildContext context,
  TriggerConfig? trigger, {
  required ValueChanged<TriggerConfig> onChanged,
}) {
  return Column(
    children: [
      // INTERVALO
      DropdownButtonFormField<String>(
        // initialValue: trigger is PeriodicTrigger ? trigger.interval : null,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ColorScheme.of(context).outlineVariant,
          ),
          labelText: AppLocalizations.of(context)!.interval,
          border: OutlineInputBorder(),
        ),
        items: Constants.periodicIntervals.map((key) {
          final String display = switchPeriodicMenuItem(context, key);
          return DropdownMenuItem<String>(value: key, child: Text(display));
        }).toList(),
        onChanged: (value) {
          final newInterval = switchNewInterval(value ?? '');
          if (trigger is PeriodicTrigger) {
            onChanged(
              trigger.copyWith(interval: Duration(minutes: newInterval)),
            );
          }
        },
      ),
      SizedBox(height: 10),
      // BOTÃO PARA SELECIONAR DATA
      Card(
        child: ListTile(
          tileColor: ColorScheme.of(context).secondary.withAlpha(50),
          title: Text(AppLocalizations.of(context)!.dateAndHour),
          subtitle: Text(
            trigger is PeriodicTrigger
                ? DateFormat('dd/MM/yyyy HH:mm').format(trigger.dateTime)
                : '',
          ),
          trailing: Icon(Icons.calendar_today),
          onTap: () async {
            final newDateTime = await dateAndHour(context, trigger);
            if (newDateTime == null) return;
            if (trigger is PeriodicTrigger) {
              onChanged(trigger.copyWith(dateTime: newDateTime));
            }
          },
        ),
      ),
    ],
  );
}

// ===========================================================================================================
// Mostra os campos de lógica e data e hora para o usuário preencher, caso o tipo de trigger seja "logical"
Widget logicalTriggerConfigWidget(
  BuildContext context,
  TriggerConfig? trigger, {
  required ValueChanged<TriggerConfig> onChanged,
}) {
  return Column(
    children: [
      // LÓGICA
      DropdownButtonFormField<String>(
        // initialValue: trigger is PeriodicTrigger ? trigger.interval : null,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ColorScheme.of(context).outlineVariant,
          ),
          labelText: AppLocalizations.of(context)!.logical,
          border: OutlineInputBorder(),
        ),
        items: Constants.logicalConditions.map((key) {
          final String display = switchLogicalMenuItem(context, key,);
          return DropdownMenuItem<String>(value: key, child: Text(display));
        }).toList(),
        onChanged: (value) {
          final newCondition = value ?? '';
          if (trigger is LogicalTrigger) {
            onChanged(
              // Altera só a condição
              trigger.copyWith(expression: newCondition)
            );
          }
        },
      ),
      SizedBox(height: 10),
      // BOTÃO PARA SELECIONAR DATA
      Card(
        child: ListTile(
          tileColor: ColorScheme.of(context).secondary.withAlpha(50),
          title: Text(AppLocalizations.of(context)!.dateAndHour),
          subtitle: Text(
            trigger is LogicalTrigger
                ? DateFormat('dd/MM/yyyy HH:mm').format(trigger.dateTime ?? DateTime.now())
                : '',
          ),
          trailing: Icon(Icons.calendar_today),
          onTap: () async {
            final newDateTime = await dateAndHour(context, trigger);
            if (newDateTime == null) return;
            if (trigger is LogicalTrigger) {
              // Altera só a data
              onChanged(trigger.copyWith(dateTime: newDateTime));
            }
          },
        ),
      ),
    ],
  );
}

// ===========================================================================================================
Future<DateTime?> dateAndHour(
  BuildContext context,
  TriggerConfig? trigger,
) async {
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

  final initialTime = switch (trigger) {
    OneshotTrigger t => TimeOfDay.fromDateTime(t.dateTime),
    PeriodicTrigger t => TimeOfDay.fromDateTime(t.dateTime),
    _ => TimeOfDay.now(),
  };

  // HORA
  if (pickedDate != null && context.mounted) {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
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
      return DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }
  }
  return null;
}

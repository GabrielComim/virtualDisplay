import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/cards_dashboard.dart';
import 'package:virtual_display/models/trigger/trigger_config.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/utils/switch_menu_item.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/widgets/select_type_keyboard.dart';

Widget triggerConfigMode(
  BuildContext context,
  String type,
  List<CardsDashboard>? cards,
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
      return logicalTriggerConfigWidget(
        context,
        trigger,
        cards,
        onChanged: onChanged,
      );
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.requiredField;
          }
          return null;
        },
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
  TriggerConfig? trigger,
  List<CardsDashboard>? cards, {
  required ValueChanged<TriggerConfig> onChanged,
}) {
  final logicalTrigger = trigger as LogicalTrigger;
  final List<CardsDashboard> filtered = filterCards(
    cards,
    logicalTrigger.operator,
  );
  final configKeyboard = selectKeyboardConfig(
    filtered,
    logicalTrigger.leftOperand ?? '',
  );

  return Column(
    children: [
      // ESCOLHE O OPERADOR LÓGICO
      DropdownButtonFormField<String>(
        // initialValue: logicalTrigger.operator,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ColorScheme.of(context).outlineVariant,
          ),
          labelText: AppLocalizations.of(context)!.logical,
          border: OutlineInputBorder(),
        ),
        items: Constants.logicalConditions.map((key) {
          final String display = switchLogicalMenuItem(context, key);
          return DropdownMenuItem<String>(value: key, child: Text(display));
        }).toList(),
        onChanged: (value) {
          onChanged(
            logicalTrigger.copyWith(operator: value ?? '', leftOperand: ''),
          );
        },
      ),
      SizedBox(height: 10),

      // ESCOLHE O ITEM PARA A LÓGICA
      DropdownButtonFormField<String>(
        // initialValue: logicalTrigger.leftExpression,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ColorScheme.of(context).outlineVariant,
          ),
          labelText: 'X',
          border: OutlineInputBorder(),
        ),
        items: filtered.map((card) {
          return DropdownMenuItem<String>(
            value: card.title,
            child: Text(card.title),
          );
        }).toList(),
        onChanged: (value) {
          final newCondition = value ?? '';
          onChanged(
            // Altera só a condição
            logicalTrigger.copyWith(leftOperand: newCondition),
          );
        },
      ),
      SizedBox(height: 10),

      // ESCOLHE O VALOR PARA A LÓGICA
      TextFormField(
        // initialValue: logicalTrigger.rightExpression,
        cursorColor: ColorScheme.of(context).secondary,
        decoration: InputDecoration(
          labelText: 'Y',
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          border: OutlineInputBorder(),
        ),
        keyboardType: configKeyboard.keyboardType,
        inputFormatters: [
          // Configura o teclado conforme o tipo de dado de X e o operador
          ...configKeyboard.formatters,
          LengthLimitingTextInputFormatter(
            configKeyboard.maxLength ?? 100,
          ), // Limita o tamanho do input
        ],
        onChanged: (value) {
          onChanged(logicalTrigger.copyWith(rightOperand: value));
        },
      ),
      SizedBox(height: 10),

      // BOTÃO PARA SELECIONAR DATA
      Card(
        child: ListTile(
          tileColor: ColorScheme.of(context).secondary.withAlpha(50),
          title: Text(AppLocalizations.of(context)!.dateAndHour),
          subtitle: Text(
            logicalTrigger.dateTime != null
                ? DateFormat(
                    'dd/MM/yyyy HH:mm',
                  ).format(logicalTrigger.dateTime!)
                : '',
          ),
          trailing: Icon(Icons.calendar_today),
          onTap: () async {
            final newDateTime = await dateAndHour(context, trigger);
            if (newDateTime == null) return;
            // Altera só a data
            onChanged(logicalTrigger.copyWith(dateTime: newDateTime));
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

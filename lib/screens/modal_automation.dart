import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/action/action_publish.dart';
import 'package:virtual_display/models/automation.dart';
import 'package:virtual_display/models/trigger/trigger_config.dart';
import 'package:virtual_display/theme/colors.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/utils/switch_menu_item.dart';
import 'package:virtual_display/viewModel/automations_viewmodel.dart';
import 'package:virtual_display/widgets/action_automation.dart';
import 'package:virtual_display/widgets/trigger_automation.dart';

Future<void> modalAutomation(
  BuildContext context, {
  Automation? automation,
}) async {
  final nameController = TextEditingController();
  bool enable = false;
  final isEdit = automation != null;
  String type = '';
  String displayType = '';
  TriggerConfig? trigger;
  ActionConfig? action;
  DateTime? selectedDateTime;

  if (isEdit) {
    nameController.text = automation.name;
    enable = automation.enable;
    type = automation.type;
    action = automation.action;
  }

  await showModalBottomSheet<bool>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: AppColors.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return SafeArea(
            child: SingleChildScrollView(
              // Campo para alterar a automação
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.automations,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 16),
                  // ============================ NOME ============================
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.name,
                      labelStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: ColorScheme.of(context).outlineVariant),
                    ),
                  ),
                  SizedBox(height: 10),
                  // ============================ TIPO ============================
                  DropdownButtonFormField<String>(
                    initialValue: type,
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: ColorScheme.of(context).outlineVariant),
                      labelText: AppLocalizations.of(context)!.type,
                      border: OutlineInputBorder(),
                    ),
                    items: Constants.typeAutomations.map((key) {
                      displayType = switchTypeMenuItem(context, key);
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Text(displayType),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setModalState(() {
                        type = v!;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  // ============================ TIPO DE AÇÃO ============================
                  DropdownButtonFormField<String>(
                    initialValue: action?.toJson()['type'],
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: ColorScheme.of(context).outlineVariant),
                      labelText: AppLocalizations.of(context)!.action,
                      border: OutlineInputBorder(),
                    ),
                    items: Constants.actionAutomations.map((key) {
                      final String displayAction = switchActionMenuItem(
                        context,
                        key,
                      );
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Text(displayAction),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setModalState(() {
                        switch (v) {
                          case Constants.actionPublish:
                            action = PublishAction(topic: '', payload: '');
                            break;
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // ============================ TOPIC AND PAYLOAD ============================
                  actionConfigMode(
                    context,
                    action,
                    selectedDateTime: selectedDateTime,
                    onChanged: (newAction) {
                      setModalState(() {
                        action = newAction;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // ============================ PERIODICIDADE ============================
                  // Depende do que foi escolhido no tipo de automação
                  Column(
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.triggerConfig}: ${switchTypeMenuItem(context, type)}',
                      ),
                      SizedBox(height: 6),
                      // Escolha da data e hora ou periodicidade ou lógica
                      triggerConfigMode(
                        context,
                        type,
                        trigger,
                        selectedDateTime: selectedDateTime,
                        onChanged: (dateTime) {
                          setModalState(() {
                            selectedDateTime = dateTime;
                            // Conforme o type define o trigger
                            switch (type) {
                              case Constants.automationOneShot:
                                trigger = OneshotTrigger(
                                  dateTime: selectedDateTime!,
                                );
                                break;
                              case Constants.automationPeriodic:
                                // trigger = PeriodicTrigger(startDate: selectedDateTime!, interval:  );
                                break;
                              case Constants.automationLogical:
                                // trigger = LogicalTrigger(expression: , validAfter: );
                                break;
                              default:
                                trigger = OneshotTrigger(
                                  dateTime: selectedDateTime!,
                                );
                                break;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                   // ============================ HABILITADA ============================
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.enable,
                        style: TextStyle(
                          color: ColorScheme.of(context).outlineVariant,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 4),
                      Checkbox(
                        activeColor: ColorScheme.of(context).secondary,
                        onChanged: (value) {
                          setModalState(() {
                            enable = value!;
                          });
                        },
                        value: enable,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context)!.ok),
                    onPressed: () async {
                      // ============================ Salvar o nova automação ou a edição ============================
                      final viewModel = context.read<AutomationsViewmodel>();
                      final newAutomation = Automation(
                        id: isEdit ? automation.id : null,
                        name: nameController.text.trim(),
                        type: type,
                        enable: enable,
                        action:
                            action ??
                            (isEdit
                                ? automation.action
                                : throw Exception('Ação não definida')),
                        trigger:
                            trigger ??
                            (isEdit
                                ? automation.trigger
                                : throw Exception('Trigger não definido')),
                      );
                      if (isEdit) {
                        await viewModel.updateAutomation(newAutomation);
                      } else {
                        await viewModel.addNewAutomation(newAutomation);
                      }
                      if (context.mounted) {
                        Navigator.pop(context, true);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/automation.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/utils/switch_menu_item.dart';
import 'package:virtual_display/viewModel/automations_viewmodel.dart';

Future<void> modalAutomation(
  BuildContext context, {
  Automation? automation,
}) async {
  final nameController = TextEditingController();
  bool enable = false;
  final isEdit = automation != null;
  String type = '';
  String action = '';
  String displayType = '';
  String displayPeriodic = '';

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
                  // NOME
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.name,
                      labelStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: ColorScheme.of(context).secondary),
                    ),
                  ),
                  SizedBox(height: 6),
                  // TIPO
                  DropdownButtonFormField<String>(
                    initialValue: type,
                    decoration: InputDecoration(
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
                        displayPeriodic = displayType;
                        type = v!;
                      });
                    },
                  ),
                  SizedBox(height: 4),
                  // HABILITADA
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.enable,
                        style: TextStyle(
                          color: ColorScheme.of(context).secondary,
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
                  SizedBox(height: 4),
                  // TIPO DE AÇÃO
                  DropdownButtonFormField<String>(
                    initialValue: action,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.action,
                      border: OutlineInputBorder(),
                    ),
                    items: Constants.actionAutomations.map((key) {
                      final String displayAction = switchActionMenuItem(context, key);
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Text(displayAction),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setModalState(() {
                        action = v!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // PERIODICIDADE
                  // Depende do que foi escolhido no tipo de automação
                  Column(
                    children: [
                      Text(displayPeriodic),
                    ],
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context)!.ok),
                    onPressed: () async {
                      // Salvar o nova automação ou a edição
                      final viewModel = context.read<AutomationsViewmodel>();
                      final newAutomation = Automation(
                        id: isEdit ? automation.id : null,
                        name: nameController.text.trim(),
                        type: type,
                        enable: enable,
                        action: type,
                        triggerConfig: type,
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

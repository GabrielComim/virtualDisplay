import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/automation.dart';
import 'package:virtual_display/models/trigger/trigger_config.dart';
import 'package:virtual_display/screens/modal_automation.dart';
import 'package:virtual_display/theme/colors.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/utils/switch_menu_item.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/widgets/icon_on_off.dart';

class CardsAutomations extends StatefulWidget {
  final Automation automation;

  // Construtor
  const CardsAutomations({super.key, required this.automation});

  @override
  State<CardsAutomations> createState() => _CardsAutomationsState();
}

class _CardsAutomationsState extends State<CardsAutomations> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerDashboard = context.watch<DashboardViewmodel>();
    final variables = providerDashboard.availableVariables;

    return InkWell(
      // Abre para EDIÇÃO
      onLongPress: () {
        modalAutomation(
          context,
          automation: widget.automation,
          cards: variables,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // INDICATIVO SE ESTÁ FUNCIONAL - QUANDO FOR DO TIPO LOGICAL
              if (widget.automation.type == Constants.automationLogical) ...[
                // Conforme o tipo do widget vinculado a automação, verificar se o trigger é funcional
                ((widget.automation.trigger as LogicalTrigger).leftOperand != null &&
                (widget.automation.trigger as LogicalTrigger).rightOperand != null) 
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.error, color: Colors.red),
              ] else ...[
                Icon(Icons.check_circle, color: Colors.green),
              ],
              // NOME
              Text(widget.automation.name, style: TextStyle(fontSize: 24)),
              SizedBox(height: 4),
              // TIPO E HABILITADO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.type}: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    switchTypeMenuItem(context, widget.automation.type),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '${AppLocalizations.of(context)!.enable}: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  iconOnOff(context, enable: widget.automation.enable),
                ],
              ),
              // AÇÃO
              Text(
                '${AppLocalizations.of(context)!.action}: ',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                '${widget.automation.action}',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              SizedBox(height: 10),
              // TRIGGER
              Text(
                '${AppLocalizations.of(context)!.triggerConfig}: ',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                '${widget.automation.trigger}',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

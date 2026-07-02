import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/automation.dart';
import 'package:virtual_display/theme/colors.dart';
import 'package:virtual_display/theme/text_type.dart';
import 'package:virtual_display/utils/constants.dart';

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // NOME
            styleText(
              context: context,
              text: widget.automation.name,
              type: Constants.titleText1,
            ),
            SizedBox(height: 4),
            // TIPO E HABILITADO
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.type}: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${widget.automation.type} ',
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
                Text(
                  '${widget.automation.enable}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            // AÇÃO
            Text(
              '${AppLocalizations.of(context)!.action}: ${widget.automation.action}',
              style: TextStyle(color: AppColors.textPrimary),
            ),

            // TRIGGER
            Text(
              '${AppLocalizations.of(context)!.triggerConfig}: ${widget.automation.trigger}',
            ),
          ],
        ),
      ),
    );
  }
}

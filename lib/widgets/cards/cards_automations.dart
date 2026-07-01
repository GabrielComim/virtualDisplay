import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/automation.dart';

class CardsAutomations extends StatefulWidget {
  final Automation automation;

  // Construtor
  const CardsAutomations({super.key, required this.automation});

  @override
  State<CardsAutomations> createState() => _CardsAutomationsState();
}

class _CardsAutomationsState extends State<CardsAutomations> {
  
  @override 
  void initState (){
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
            Text(widget.automation.name),
            SizedBox(height: 4),
            // TIPO E HABILITADO
            Row(
              children: [
                Text('${AppLocalizations.of(context)!.type}: ${widget.automation.type}'),
                SizedBox(width: 4),
                Text('${AppLocalizations.of(context)!.enable}: ${widget.automation.enable}'),
              ],
            ),
            // AÇÃO
            Text('${AppLocalizations.of(context)!.action}: ${widget.automation.action}'),

            // TRIGGER
            Text('${AppLocalizations.of(context)!.triggerConfig}: ${widget.automation.triggerConfig}'),
          ]
        ),
      ),
    );
  }
}

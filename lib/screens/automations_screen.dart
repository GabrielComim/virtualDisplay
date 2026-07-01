import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/screens/modal_automation.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/viewModel/automations_viewmodel.dart';
import 'package:virtual_display/widgets/cards/cards_automations.dart';
// import 'package:virtual_display/utils/constants.dart';

class AutomationsScreen extends StatefulWidget {
  const AutomationsScreen({super.key});

  @override
  State<AutomationsScreen> createState() => _AutomationsScreenState();
}

class _AutomationsScreenState extends State<AutomationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationInitScreen(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.selected)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // NOVA AUTOMAÇÃO
              ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text(AppLocalizations.of(context)!.addAutomation),
                onPressed: () async {
                  // ADICIONAR NOVA AUTOMAÇÃO
                  modalAutomation(context);
                },
              ),
              SizedBox(height: 10),
              // Cria os cards conforme detecta dispositivos conectados
              Expanded(
                child: Consumer<AutomationsViewmodel>(
                  builder: (context, viewModel, child) {
                    return ListView.builder(
                      itemCount: viewModel.automations.length,
                      itemBuilder: (context, index) {
                        final automation = viewModel.automations[index];
                        return Column(
                          children: [
                            CardsAutomations(
                              automation: automation,
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/screens/modal_automation.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/viewModel/automations_viewmodel.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/widgets/cards/cards_automations.dart';
import 'package:virtual_display/widgets/delete_slide_tip.dart';
import 'package:virtual_display/widgets/delete_with_slide_widget.dart';
// import 'package:virtual_display/utils/constants.dart';

class AutomationsScreen extends StatefulWidget {
  const AutomationsScreen({super.key});

  @override
  State<AutomationsScreen> createState() => _AutomationsScreenState();
}

class _AutomationsScreenState extends State<AutomationsScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AutomationsViewmodel>(context, listen: false);
    provider.loadAutomations();
  }

  @override
  Widget build(BuildContext context) {
    final providerDashboard = context.watch<DashboardViewmodel>();
    final variables = providerDashboard.availableVariables;
    
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
                  modalAutomation(context, cards: variables);
                },
              ),
              SizedBox(height: 10),
              // Dica de como excluir
              deleteWithSlideTip(context: context),
              // Cria os cards conforme detecta dispositivos conectados
              Expanded(
                child: Consumer<AutomationsViewmodel>(
                  builder: (context, viewModel, child) {
                    return ListView.builder(
                      itemCount: viewModel.automations.length,
                      itemBuilder: (context, index) {
                        final automation = viewModel.automations[index];
                        return deleteWithSlideWidget(
                          context,
                          id: automation.id!,
                          onDismissed: () async {
                            await context
                                .read<AutomationsViewmodel>()
                                .removeAutomation(automation.id!);
                          },
                          child: Column(
                            children: [
                              CardsAutomations(automation: automation),
                              SizedBox(height: 20),
                            ],
                          ),
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

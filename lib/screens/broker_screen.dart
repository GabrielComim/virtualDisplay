import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/screens/modal_config_broker.dart';
import 'package:virtual_display/viewModel/credential_viewmodel.dart';
import 'package:virtual_display/theme/widgets/app_bar_title_custom.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/widgets/buttons/button_more_options.dart';
import 'package:virtual_display/widgets/cards/cards_broker.dart';

class BrokerScreen extends StatefulWidget {
  const BrokerScreen({super.key});

  @override
  State<BrokerScreen> createState() => _BrokerScreenState();
}

class _BrokerScreenState extends State<BrokerScreen> {
  bool deviceStatus = false;

  void _initialize() async {
    final provider = Provider.of<CredentialViewmodel>(context, listen: false);
    provider.loadCredentials();
  }

  @override
  void initState() {
    super.initState();
    _initialize(); 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationInitScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitleCustom(
            textScreen: AppLocalizations.of(context)!.devicesKnown,
          ),
          actions: [buttonMoreOptions(context)],
        ),
        body: Column(
          children: [
            // Botão para nova conexão
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.labelIconAdd),
              onPressed: () async {
                await modalConfigBroker(context);
              },
            ),
            // Cria os cards conforme detecta dispositivos conectados
            Expanded(
              child: Consumer<CredentialViewmodel>(
                builder: (context, viewModel, child) {
                    log('TOTAL BROKERS: ${viewModel.credentials.length}');
                  return ListView.builder(
                    itemCount: viewModel.credentials.length,
                    itemBuilder: (context, index) {
                      final broker = viewModel.credentials[index];
                      return Column(
                        children: [
                          CardsBroker(credentials: broker),
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
    );
  }
}

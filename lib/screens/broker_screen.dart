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
import 'package:vibration/vibration.dart';

class BrokerScreen extends StatefulWidget {
  const BrokerScreen({super.key});

  @override
  State<BrokerScreen> createState() => _BrokerScreenState();
}

class _BrokerScreenState extends State<BrokerScreen> {
  bool deviceStatus = false;
  bool _selectionMode = false;
  final Set<int> _selectedBrokers = {};

  Widget _buttonsFloating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _selectedBrokers.length == 1
            ? FloatingActionButton.extended(
                backgroundColor: ColorScheme.of(context).secondary,
                onPressed: () async {
                  final viewModel = context.read<CredentialViewmodel>();
                  final broker = viewModel.credentials.firstWhere(
                    (item) => item.id == _selectedBrokers.first,
                  );
                  await modalConfigBroker(context, credential: broker);
                },
                icon: Icon(Icons.edit),
                label: Text(AppLocalizations.of(context)!.edit),
              )
            : SizedBox.shrink(),
        SizedBox(width: 20),
        FloatingActionButton.extended(
          backgroundColor: ColorScheme.of(context).secondary,
          onPressed: () async {
            final viewModel = context.read<CredentialViewmodel>();
            for (final broker in _selectedBrokers) {
              await viewModel.removeCredentialsBroker(broker);
            }
          },
          icon: Icon(Icons.delete),
          label: Text(AppLocalizations.of(context)!.delete),
        ),
      ],
    );
  }

  Future<void> _enterSelectionMode(int brokerId) async {
    setState(() {
      _selectionMode = true;
      _selectedBrokers.add(brokerId);
    });
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 50);
    }
  }

  void _toggleBrokerSelection(int brokerId, bool selected) {
    setState(() {
      if (selected) {
        _selectedBrokers.add(brokerId);
      } else {
        _selectedBrokers.remove(brokerId);
      }

      if (_selectedBrokers.isEmpty) {
        _selectionMode = false;
      }
    });
  }

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
          title: _selectionMode
              ? Text(
                  '${_selectedBrokers.length} ${AppLocalizations.of(context)!.selected}',
                )
              : AppBarTitleCustom(
                  textScreen: AppLocalizations.of(context)!.devicesKnown,
                ),
          leading: _selectionMode
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _selectionMode = false;
                      _selectedBrokers.clear();
                    });
                  },
                )
              : null,
          actions: _selectionMode ? [] : [buttonMoreOptions(context)],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _selectionMode ? _buttonsFloating() : null,
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
                          CardsBroker(
                            credentials: broker,
                            selectionMode: _selectionMode,
                            selected: _selectedBrokers.contains(broker.id),
                            onSelected: (value) {
                              _toggleBrokerSelection(
                                broker.id!,
                                value ?? false,
                              );
                            },
                            onLongPress: () async {
                              await _enterSelectionMode(broker.id!);
                            },
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
    );
  }
}

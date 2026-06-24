import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/credentials_broker.dart';
import 'package:virtual_display/theme/widgets/app_bar_title_custom.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/viewModel/devices_viewmodel.dart';
import 'package:virtual_display/widgets/buttons/button_more_options.dart';
import 'package:virtual_display/widgets/cards/cards_devices.dart';

class DeviceScreen extends StatefulWidget {
  final CredentialsBroker credential;
  const DeviceScreen({super.key, required this.credential});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            // Cria os cards conforme detecta dispositivos conectados
            Expanded(
              child: Consumer<DevicesViewModel>(
                builder: (context, viewModel, child) {
                  return ListView.builder(
                    itemCount: viewModel.devices.length,
                    itemBuilder: (context, index) {
                      final deviceInfo = viewModel.devices[index];
                      return Column(
                        children: [
                          CardsDevices(
                            deviceName: deviceInfo.device,
                            deviceStatus: deviceInfo.online,
                            credential: widget.credential,
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

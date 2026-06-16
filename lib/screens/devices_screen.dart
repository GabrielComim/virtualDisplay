import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/theme/widgets/app_bar_title_custom.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/widgets/cards/cards_devices.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationInitScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitleCustom(textScreen: AppLocalizations.of(context)!.devicesKnown),
        ),
        body: Column(
          children: [
            SizedBox(height: 20), // Espaçamento entre o AppBar e o primeiro card
            CardsDevices(deviceName: 'Dispositivo 1', deviceStatus: 'Desconectado'),
            SizedBox(height: 20), 
            CardsDevices(deviceName: 'Dispositivo 2', deviceStatus: 'Desconectado'),
            SizedBox(height: 20),
            CardsDevices(deviceName: 'Dispositivo 2', deviceStatus: 'Desconectado'),
            SizedBox(height: 20),],
        ),
      ),
    );
  }
}

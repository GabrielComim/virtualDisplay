import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/theme/widgets/app_bar_title_custom.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';

class ProtocolScreen extends StatelessWidget {
  final versionProtocol = 1.0;
  // Construtor
  const ProtocolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationInitScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitleCustom(
            textScreen: AppLocalizations.of(context)!.appTitle,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(AppLocalizations.of(context)!.protocol, style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text('${AppLocalizations.of(context)!.versionProtocol} $versionProtocol'),
                Text(AppLocalizations.of(context)!.formatJson),
                SizedBox(height: 20),
                Text(AppLocalizations.of(context)!.titleHowToSendProtocol, style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text(AppLocalizations.of(context)!.bodyPageOneHowToSendProtocol),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/screens/modal_config_broker.dart';
import 'package:virtual_display/utils/constants.dart';

Widget buttonMoreOptions(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (String value) {
      switch (value) {
        // Tela que explica o protocolo de comunicação
        case Constants.screenProtocol:
          Navigator.pushNamed(context, Constants.screenProtocol);
        // Modal para configurar um broker próprio
        case Constants.screenModalConnection:
          modalConfigBroker(context);
      }
    },
    itemBuilder: (BuildContext context) => [
      PopupMenuItem<String>(
        value: Constants.screenModalConnection,
        child: Text(AppLocalizations.of(context)!.configAdvanced),
      ),
      PopupMenuItem<String>(
        value: Constants.screenProtocol,
        child: Text(AppLocalizations.of(context)!.comProtocol),
      ),
    ],
  );
}

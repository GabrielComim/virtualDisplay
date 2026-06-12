import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/utils/constants.dart';

Widget buttonMoreOptions(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (String value) {
      switch (value) {
        case Constants.screenProtocol:
          Navigator.pushNamed(context, Constants.screenProtocol);
      }
    },
    itemBuilder: (BuildContext context) => [
      PopupMenuItem<String>(
        value: Constants.screenDevices,
        child: Text(AppLocalizations.of(context)!.configAdvanced),
      ),
      PopupMenuItem<String>(
        value: Constants.screenProtocol,
        child: Text(AppLocalizations.of(context)!.comProtocol),
      ),
    ],
  );
}
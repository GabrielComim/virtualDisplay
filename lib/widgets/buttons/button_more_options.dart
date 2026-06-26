import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/services/export/csv_export.dart';
import 'package:virtual_display/utils/constants.dart';

Widget buttonMoreOptions(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (String value) {
      switch (value) {
        // Tela que explica o protocolo de comunicação
        case Constants.screenProtocol:
          Navigator.pushNamed(context, Constants.screenProtocol);
      }
    },
    itemBuilder: (BuildContext context) => [
      PopupMenuItem<String>(
        value: Constants.screenProtocol,
        child: Text(AppLocalizations.of(context)!.comProtocol),
      ),
    ],
  );
}

Widget buttonMoreOptionsMainScreen(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (String value) async {
      switch (value) {
        // Tela para exportar os gráficos
        case Constants.screenExportCSV:
          // await CsvExport.exportchart();
      }
    },
    itemBuilder: (BuildContext context) => [
      PopupMenuItem<String>(
        value: Constants.screenExportCSV,
        child: Text(AppLocalizations.of(context)!.exportCSV),
      ),
    ],
  );
}
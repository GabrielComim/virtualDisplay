import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/chart_data.dart';
import 'package:virtual_display/services/export/csv_export.dart';
import 'package:virtual_display/utils/constants.dart';

Widget buttonMoreOptions(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (String value) {
      switch (value) {
        // Tela que explica o protocolo de comunicação
        case Constants.screenProtocol:
          Navigator.pushNamed(context, Constants.screenProtocol);
        case Constants.screenAutomations:
          Navigator.pushNamed(context, Constants.screenAutomations);
      }
    },
    itemBuilder: (BuildContext context) => [
      PopupMenuItem<String>(
        value: Constants.screenProtocol,
        child: Text(AppLocalizations.of(context)!.comProtocol),
      ),
      PopupMenuItem<String>(
        value: Constants.screenAutomations,
        child: Text(AppLocalizations.of(context)!.automations),
      ),
    ],
  );
}

Widget buttonMoreOptionsMainScreen(BuildContext context, ChartData chartData) {
  return PopupMenuButton<String>(
    onSelected: (String value) async {
      switch (value) {
        // Tela para exportar os gráficos
        case Constants.screenExportCSV:
          await CsvExport().exportChart(chartData: chartData);
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
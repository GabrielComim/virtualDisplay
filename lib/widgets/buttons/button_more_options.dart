import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/chart_data.dart';
import 'package:virtual_display/models/message_sample.dart';
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

Widget buttonMoreOptionsMainScreen(
  BuildContext context,
  ChartData chartData,
  int brokerId,
  String deviceName,
) {
  return PopupMenuButton<String>(
    onSelected: (String value) async {
      switch (value) {
        // Tela para exportar os gráficos
        case Constants.screenExportCSV:
          await CsvExport().exportChart(chartData: chartData);
        // Tela para automações
        case Constants.screenAutomations:
          Navigator.pushNamed(
            context,
            Constants.screenAutomations,
            arguments: {'brokerId': brokerId, 'deviceName': deviceName},
          );
      }
    },
    itemBuilder: (BuildContext context) => [
      PopupMenuItem<String>(
        value: Constants.screenExportCSV,
        child: Text(AppLocalizations.of(context)!.exportCSV),
      ),
      PopupMenuItem<String>(
        value: Constants.screenAutomations,
        child: Text(AppLocalizations.of(context)!.automations),
      ),
    ],
  );
}

Widget buttonExportCsvMessages(BuildContext context, int brokerId, String deviceName, List<MessageSample> messages) {
  return PopupMenuButton<String>(
    onSelected: (String value) async {
      switch (value) {
        // Tela para exportar mensagens CSV
        case Constants.screenExportCSV:
          await CsvExport().exportLogMessage(message: messages);
      }
    },
    itemBuilder: (BuildContext context) => [
      PopupMenuItem<String>(
        value: Constants.screenExportCSV,
        child: Text(AppLocalizations.of(context)!.exportCSVLog),
      ),
    ],
  );
}

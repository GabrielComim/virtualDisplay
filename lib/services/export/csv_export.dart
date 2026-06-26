import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:virtual_display/models/chart_data.dart';

class CsvExport {
  Future<void> exportchart({
    required ChartData chartData,
  }) async {
    if(chartData.samples.isEmpty) return;

    final buffer = StringBuffer();

    buffer.writeln('Title;${chartData.title}');
    buffer.writeln('Unit;${chartData.unit}');
    buffer.writeln('');
    buffer.writeln('Timestamp/Elapsed(s)/Value');

    final baseTime = chartData.samples.first.timestamp;
    for(final sample  in chartData.samples) {
      final elapsed = sample.timestamp.difference(baseTime).inSeconds;

      final timestamp = sample.timestamp.toIso8601String();
      final value = sample.value.toStringAsFixed(2);

      buffer.writeln('$timestamp;$elapsed;$value');
    }

    final csvContent = buffer.toString();
    // Escolher local para salvar
    final outputPath = await FilePicker.saveFile(
      dialogTitle: 'Salvar CSV',
      fileName: '${_sanitizeFileName(chartData.title)}.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

     if (outputPath == null) return; // usuário cancelou

    final file = File(outputPath);
    await file.writeAsString(csvContent);
  }

  String _sanitizeFileName(String input) {
    return input
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^\w\-]'), '');
  }
 }
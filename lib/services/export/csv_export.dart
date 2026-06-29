import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:virtual_display/models/chart_data.dart';

class CsvExport {
  Future<void> exportChart({required ChartData chartData}) async {
    if (chartData.samples.isEmpty) return;

    final buffer = StringBuffer();

    buffer.writeln('Title;${chartData.title}');
    buffer.writeln('Unit;${chartData.unit}');
    buffer.writeln('');
    buffer.writeln('Timestamp/Elapsed(s);Value');

    final baseTime = chartData.samples.first.timestamp;
    for (final sample in chartData.samples) {
      final elapsed = sample.timestamp.difference(baseTime).inSeconds;

      final timestamp = sample.timestamp.toIso8601String();
      final value = sample.value.toStringAsFixed(2);

      buffer.writeln('$timestamp;$elapsed;$value');
    }

    final csvContent = buffer.toString();

    // Diretório temporário do App
    final tempDir = await getTemporaryDirectory();

    final file = File(
      '${tempDir.path}/${_sanitizeFileName(chartData.title)}.csv',
    );

    await file.writeAsString(csvContent);
    log('CSV CRIADO EM ${file.path}');

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        subject: chartData.title,
        text: 'CSV exported from Virtual Display',
      ),
    );
  }

  String _sanitizeFileName(String input) {
    return input
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^\w\-]'), '');
  }
}

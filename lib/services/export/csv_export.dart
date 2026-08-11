import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:virtual_display/models/chart_data.dart';
import 'package:virtual_display/models/message_sample.dart';

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

  Future<void> exportLogMessage({required List<MessageSample> message}) async {
    if (message.isEmpty) return;

    final buffer = StringBuffer();

    buffer.writeln('Timestamp;Message');

    for (final msg in message) {
      final timestamp = msg.time.toIso8601String();
      final text = msg.value.replaceAll(';', ','); // Evita conflito com o delimitador CSV
      buffer.writeln('$timestamp;$text');
    }

    final csvContent = buffer.toString();

    // Diretório temporário do App
    final tempDir = await getTemporaryDirectory();

    final file = File(
      '${tempDir.path}/log_messages.csv',
    );

    await file.writeAsString(csvContent);
    log('CSV CRIADO EM ${file.path}');

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        subject: 'Log Messages',
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

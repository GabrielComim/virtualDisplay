import 'package:virtual_display/models/chart_sample.dart';

class ChartData {
  final String title;
  final String unit;
  final List<ChartSample> samples;

  ChartData({
    required this.title,
    required this.unit,
    required this.samples,
  });
}
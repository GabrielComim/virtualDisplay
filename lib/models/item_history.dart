import 'package:virtual_display/models/chart_sample.dart';

class ItemHistory {
  final int maxSize;
  final List<ChartSample> samples = [];

  ItemHistory({this.maxSize = 3600});

  void add(ChartSample sample) {
    samples.add(sample);
    if(samples.length > maxSize) {
      samples.removeAt(0);
    }
  }
}
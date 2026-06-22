import 'package:virtual_display/models/item_sample.dart';

class ItemHistory {
  final int maxSize;
  final List<ItemSample> samples = [];

  ItemHistory({this.maxSize = 3600});

  void add(ItemSample sample) {
    samples.add(sample);
    if(samples.length > maxSize) {
      samples.removeAt(0);
    }
  }
}
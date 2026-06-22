// import 'package:virtual_display/models/item_history.dart';
// import 'package:virtual_display/models/item_sample.dart';

// class HistoryRepositoryViewmodel {
//   static final HistoryRepositoryViewmodel instance = HistoryRepositoryViewmodel._internal();

//   HistoryRepositoryViewmodel._internal();

//   final Map<String, ItemHistory> _histories = {};

//   void addSample(
//     String key,
//     double value,
//   ) {
//     _histories.putIfAbsent(
//       key,
//       () => ItemHistory(key),
//     );

//     _histories[key]!.samples.add(
//       ItemSample(timestamp: DateTime.now(), value: value)
//     );
//   }
// }
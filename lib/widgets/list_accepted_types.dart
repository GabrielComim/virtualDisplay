import 'package:virtual_display/utils/constants.dart';

List<String> acceptedTypes(String expression) {
  switch(expression) {
    case Constants.logicalConditionMinor:
      return [
        Constants.cardTypeNumber,
      ];
    case Constants.logicalConditionMinorEqual:
      return [
        Constants.cardTypeNumber,
      ];
    case Constants.logicalConditionMajor:
      return [
        Constants.cardTypeNumber,
      ];
    case Constants.logicalConditionMajorEqual:
      return [
        Constants.cardTypeNumber,
      ];
    case Constants.logicalConditionEqual:
      return [
        Constants.cardTypeNumber,
        Constants.cardTypeString,
      ];
    case Constants.logicalConditionNot:
      return [
        Constants.cardTypeBool,
      ];
    case Constants.logicalConditionAnd:
      return [
        Constants.cardTypeBool,
      ];
    default: 
      return [];
  }
} 

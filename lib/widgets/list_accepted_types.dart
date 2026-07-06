import 'package:virtual_display/utils/constants.dart';

List<String> acceptedTypes(String expression) {
  switch(expression) {
    case Constants.logicalConditionMinor:
    case Constants.logicalConditionMinorEqual:
    case Constants.logicalConditionMajor:
    case Constants.logicalConditionMajorEqual:
      return [
        Constants.cardTypeNumber,
      ];

    case Constants.logicalConditionEqual:
    case Constants.logicalConditionNot:
      return [
        Constants.cardTypeNumber,
        Constants.cardTypeBool,
        Constants.cardTypeString,
      ];
    case Constants.logicalConditionAnd:
    case Constants.logicalConditionOr:
      return [
        Constants.cardTypeBool,
      ];
    default: 
      return [];
  }
} 

import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/utils/constants.dart';

String switchTypeMenuItem(BuildContext context, String key) {
  switch (key) {
    case Constants.automationOneShot:
      return AppLocalizations.of(context)!.oneShot;
    case Constants.automationPeriodic:
      return AppLocalizations.of(context)!.periodic;
    case Constants.automationLogical:
      return AppLocalizations.of(context)!.logical;
    default: 
      return '';
  }
}

String switchActionMenuItem(BuildContext context, String key) {
  switch (key) {
    case 'publish':
      return AppLocalizations.of(context)!.publish;
    default: 
      return '';
  }
}

String switchPeriodicMenuItem(BuildContext context, String key) {
  switch (key) {
    case Constants.automationInterval1Minute:
      return AppLocalizations.of(context)!.oneMinute;
    case Constants.automationInterval5Minutes:
      return AppLocalizations.of(context)!.fiveMinutes;
    case Constants.automationInterval10Minutes:
      return AppLocalizations.of(context)!.tenMinutes;
    case Constants.automationInterval15Minutes:
      return AppLocalizations.of(context)!.fifteenMinutes;
    case Constants.automationInterval30Minutes:
      return AppLocalizations.of(context)!.thirdMinutes;
    case Constants.automationInterval1Hour:
      return AppLocalizations.of(context)!.oneHour;
    case Constants.automationInterval2Hours:
      return AppLocalizations.of(context)!.twoHours;
    case Constants.automationInterval6Hours:
      return AppLocalizations.of(context)!.sixHours;
    case Constants.automationInterval12Hours:
      return AppLocalizations.of(context)!.elevenHours;
    case Constants.automationInterval1Day:
      return AppLocalizations.of(context)!.oneDay;
    case Constants.automationInterval2Days:
      return AppLocalizations.of(context)!.twoDays;
    case Constants.automationInterval1Week:
      return AppLocalizations.of(context)!.oneWeek;
    case Constants.automationInterval1Month:
      return AppLocalizations.of(context)!.oneMonth;
    default: 
      return '';
  }
}

int switchNewInterval(String value) {
  switch(value) {
    case Constants.automationInterval1Minute:
      return 1;
    case Constants.automationInterval5Minutes:
      return 5;
    case Constants.automationInterval10Minutes:
      return 10;
    case Constants.automationInterval15Minutes:
      return 15;
    case Constants.automationInterval30Minutes:
      return 30;
    case Constants.automationInterval1Hour:
      return 60;
    case Constants.automationInterval2Hours:
      return 120;
    case Constants.automationInterval6Hours:
      return 360;
    case Constants.automationInterval12Hours:
      return 720;
    case Constants.automationInterval1Day:
      return 1440;
    case Constants.automationInterval2Days:
      return 2880;
    case Constants.automationInterval1Week:
      return 10080;
    case Constants.automationInterval1Month:
      return 43200;
    default: 
      return 1;
  }
}

String switchLogicalMenuItem(BuildContext context, String key) {
  switch (key) {
    case Constants.logicalConditionAnd:
      return 'x ${Constants.logicalConditionAnd} y';
    case Constants.logicalConditionNot:
      return 'x ${Constants.logicalConditionNot} y';
    case Constants.logicalConditionEqual:
      return 'x ${Constants.logicalConditionEqual} y';
    case Constants.logicalConditionMinor:
      return 'x ${Constants.logicalConditionMinor} y';
    case Constants.logicalConditionMinorEqual:
      return 'x ${Constants.logicalConditionMinorEqual} y';
    case Constants.logicalConditionMajor:
      return 'x ${Constants.logicalConditionMajor} y';
    case Constants.logicalConditionMajorEqual:
      return 'x ${Constants.logicalConditionMajorEqual} y';
    default: 
      return '';
  }
}

    
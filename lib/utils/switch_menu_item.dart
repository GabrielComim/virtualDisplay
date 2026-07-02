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


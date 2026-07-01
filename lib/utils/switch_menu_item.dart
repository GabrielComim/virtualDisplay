import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';

String switchTypeMenuItem(BuildContext context, String key) {
  switch (key) {
    case 'oneShot':
      return AppLocalizations.of(context)!.oneShot;
    case 'periodic':
      return AppLocalizations.of(context)!.periodic;
    case 'logical':
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
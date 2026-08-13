import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/theme/colors.dart';

Widget confirmDeleteDialog(BuildContext context) {
  return AlertDialog(
    title: Text(
      AppLocalizations.of(context)!.confirmExclude,
      style: Theme.of(context).textTheme.titleLarge,
    ),
    content: Text(AppLocalizations.of(context)!.confirmExcludeAgain),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(
          AppLocalizations.of(context)!.cancel,
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(
          AppLocalizations.of(context)!.delete,
          style: TextStyle(color: Colors.red),
        ),
      ),
    ],
  );
}

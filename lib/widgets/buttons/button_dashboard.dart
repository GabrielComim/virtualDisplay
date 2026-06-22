import 'package:flutter/material.dart';
import 'package:virtual_display/utils/constants.dart';

Widget buttonDashboard(BuildContext context, {required void Function() onButton}) {
  return ElevatedButton.icon(
    iconAlignment: IconAlignment.end,
    onPressed: onButton,
    label: Text(''),
    icon: Image.asset(
      Constants.iconButton,
      width: 20,
      height: 20,
      color: ColorScheme.of(context).primaryContainer,
    ),
  );
}

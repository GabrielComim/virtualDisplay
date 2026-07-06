import 'package:flutter/material.dart';
import 'package:virtual_display/utils/constants.dart';

Widget iconOnOff(BuildContext context, {required bool enable}) {
  return enable
    ? Image.asset(
        Constants.iconOn,
        width: 40,
        height: 40,
      )
    : Image.asset(
        Constants.iconOff,
        width: 50,
        height: 50,
      ); 
}
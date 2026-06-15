import 'package:flutter/material.dart';
import '../../utils/constants.dart';

Widget styleText({required BuildContext context ,required String text, required String type}) {
  return 
    switch(type){
      Constants.titleText1 =>
        Text(
          text,
          style:Theme.of(context).textTheme.titleLarge,
          softWrap: true,
          overflow: TextOverflow.visible,
          maxLines: 2,
        ),
      Constants.titleText2 =>
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      Constants.titleText3 =>
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      Constants.titleText4 =>
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.visible,
          ),
        ),
      Constants.subtitleText1 =>
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      Constants.subtitleText2 =>
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            overflow: TextOverflow.visible,
          ),
        ),
      Constants.subtitleText3 =>
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
            overflow: TextOverflow.visible,
          ),
        ),
      Constants.bodyText1 =>
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            // overflow: TextOverflow.visible,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      Constants.bodyText2 =>
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.visible,
          ),
        ),
      Constants.bodyText3 =>
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
            overflow: TextOverflow.visible,
          ),
        ),
      Constants.bodyText4 =>
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
            overflow: TextOverflow.visible,
          ),
        ),
      Constants.bodyText5 =>
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      Constants.bodyText6 =>
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Default
      _ => Text(text),
    };
}

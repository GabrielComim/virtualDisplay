import 'package:flutter/material.dart';
import 'dart:async';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/utils/globals.dart';

class ShowBanner {

  static Timer? _timer;
  
  static void messengerShow(BuildContext context, String message, bool isError) {
    final Color color = isError ? Theme.of(context).colorScheme.errorContainer : Theme.of(context).colorScheme.primaryContainer;
    
    showMaterialBanner(color, message, AppLocalizations.of(context)!.ok);
  } 

  static void showMaterialBanner(Color color, String message, String msgButton) {
    
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;
    // Remove qualquer banner ativo antes de mostrar um novo
    messenger.clearMaterialBanners();
    // Cancela qualquer timer anterior
    _timer?.cancel();

    messenger.showMaterialBanner(
      MaterialBanner(
        content: Text(message),
        backgroundColor: color,
        actions: [
          TextButton(
            onPressed: () {
              messenger.hideCurrentMaterialBanner();
            },
            child: Text(msgButton),
          ),
        ],
      ),
    );
    _timer = Timer(Duration(seconds: 4), () {
      messenger.hideCurrentMaterialBanner();
    });
  }
}
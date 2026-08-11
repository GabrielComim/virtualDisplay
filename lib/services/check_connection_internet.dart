import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/widgets/show_material_banner.dart';

  Future<bool> checkConnectionInternet(BuildContext context) async {
    // Verifica a conexão do dispositivo com a internet
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult.contains(ConnectivityResult.none)) {
      // Sem conexão
      if(!context.mounted)return false;
      ShowBanner.messengerShow(context, AppLocalizations.of(context)!.errorConection, true);
      return false;
    }
    return true;
  }
import 'package:flutter/material.dart';
// Usado para suporte a múltiplos idiomas
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:virtual_display/screens/main_screen.dart';
import 'package:virtual_display/utils/constants.dart';  
import 'l10n/app_localizations.dart';

import 'package:virtual_display/screens/devices_screen.dart';
import 'package:virtual_display/theme/app_theme.dart';

// ========================= Para atualizar os arquivos de strings: =========================================================
// flutter gen-l10n --arb-dir=lib/l10n --template-arb-file=app_pt.arb --output-localization-file=app_localizations.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Configurações de localização para suporte a múltiplos idiomas
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Virtual Display',
      theme: AppTheme.darkTheme,
      initialRoute: Constants.screenDevices,
      onGenerateRoute: (settings) {
        // TELA DOS DISPOSITIVOS CONECTADOS
        if (settings.name == Constants.screenDevices) {
          return MaterialPageRoute(builder: (context) => const DevicesScreen());
        }
        if(settings.name == Constants.screenMain) {
          final args = settings.arguments as Map<String, dynamic>?;

          final List<String> typeCard = (args?['typeCard'] as List<dynamic>?)?.cast<String>() ?? [];
          final List<int> minValue = (args?['minValue'] as List<dynamic>?)?.cast<int>() ?? [];
          final List<int> maxValue = (args?['maxValue'] as List<dynamic>?)?.cast<int>() ?? [];

          return PageRouteBuilder(
            pageBuilder: (_, _, _) => MainScreen(
              deviceName: 'Dispositivo Exemplo', 
              deviceStatus: 'Conectado', 
              numberOfCards: typeCard.length, 
              typeCard: typeCard, 
              minValue: minValue, 
              maxValue: maxValue
            ),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: Duration(milliseconds: 250),
          );
        }
        return null; // Retorna null para rotas não definidas, o que resultará em uma tela de erro padrão.
      },
    );
  }
}

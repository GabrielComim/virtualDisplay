import 'package:flutter/material.dart';
import 'package:virtual_display/screens/protocol_screen.dart';
import 'package:virtual_display/utils/constants.dart';  
import 'package:virtual_display/theme/app_theme.dart';

// Usado para suporte a múltiplos idiomas
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
// Telas
import 'package:virtual_display/screens/main_screen.dart';
import 'package:virtual_display/screens/devices_screen.dart';

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
          final List<String> idCard = (args?['idCard'] as List<dynamic>?)?.cast<String>() ?? [];
          final List<String> title = (args?['title'] as List<dynamic>?)?.cast<String>() ?? [];
          final List<String> value = (args?['value'] as List<dynamic>?)?.cast<String>() ?? [];
          final List<String> unit = (args?['unit'] as List<dynamic>?)?.cast<String>() ?? [];

          return PageRouteBuilder(
            pageBuilder: (_, _, _) => MainScreen(
              deviceName: 'Dispositivo Exemplo', 
              deviceStatus: 'Conectado', 
              idCard: idCard,
              title: title,
              value: value,
              unit: unit,
              typeCard: typeCard, 
              minValue: minValue, 
              maxValue: maxValue
            ),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: Duration(milliseconds: 250),
          );
        } else if(settings.name == Constants.screenProtocol) {
          return MaterialPageRoute(builder: (context) => const ProtocolScreen());
        }
        return null; // Retorna null para rotas não definidas, o que resultará em uma tela de erro padrão.
      },
    );
  }
}

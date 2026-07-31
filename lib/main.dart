import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/models/credentials_broker.dart';
import 'package:virtual_display/screens/automations_screen.dart';
import 'package:virtual_display/screens/demontration_screen.dart';
import 'package:virtual_display/screens/device_screen.dart';
import 'package:virtual_display/screens/help_screen.dart';
import 'package:virtual_display/screens/protocol_screen.dart';
import 'package:virtual_display/viewModel/automations_viewmodel.dart';
import 'package:virtual_display/viewModel/credential_viewmodel.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/viewModel/mqtt_connection_vm.dart';
import 'package:virtual_display/viewModel/mqtt_publish_vm.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/theme/app_theme.dart';
import 'firebase_options.dart';

// Usado para suporte a múltiplos idiomas
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:virtual_display/utils/globals.dart';
// ViewModels
import 'package:virtual_display/viewModel/devices_viewmodel.dart';
import 'l10n/app_localizations.dart';
// Telas
import 'package:virtual_display/screens/main_screen.dart';
import 'package:virtual_display/screens/broker_screen.dart';

// ========================= Para atualizar os arquivos de strings: =========================================================
// flutter gen-l10n --arb-dir=lib/l10n --template-arb-file=app_pt.arb --output-localization-file=app_localizations.dart

void main() {
  // Configurar o tratamento de erros de zona antes de qualquer inicialização
  BindingBase.debugZoneErrorsAreFatal = true;

  runZonedGuarded(
    () async {
      // Inicializa o binding do Flutter dentro da zona protegida
      WidgetsFlutterBinding.ensureInitialized();

    // Inicializa o Firebase
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      // Configura o Crashlytics
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

      // Inicializar o Analytics
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

      // Captura erros do Flutter
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => DevicesViewModel()),
            ChangeNotifierProvider(create: (_) => MqttPublishVm()),
            ChangeNotifierProvider(create: (_) => MqttConnectionVm()),
            ChangeNotifierProvider(create: (_) => DashboardViewmodel()),
            ChangeNotifierProvider(create: (_) => CredentialViewmodel()),
            ChangeNotifierProvider(create: (_) => AutomationsViewmodel()),
          ],
          child: const MyApp(),
        ),
      );
    },
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey:
          scaffoldMessengerKey, // Key para mostrar banners globalmente
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
      initialRoute: Constants.screenBroker,
      onGenerateRoute: (settings) {
        // TELA DOS BROKERS
        if (settings.name == Constants.screenBroker) {
          return MaterialPageRoute(builder: (context) => const BrokerScreen());
        }
        // TELA DISPOSITIVOS
        else if (settings.name == Constants.screenDevices) {
          final args = settings.arguments as Map<String, dynamic>?;
          final credential = (args?['credentialBroker'] as CredentialsBroker);

          return MaterialPageRoute(
            builder: (context) => DeviceScreen(credential: credential),
          );
        }
        // TELA PRINCIPAL
        else if (settings.name == Constants.screenMain) {
          final args = settings.arguments as Map<String, dynamic>?;

          final deviceName = (args?['deviceName'] as String? ?? 'Dis');
          final deviceStatus =
              (args?['deviceStatus'] as String? ?? 'Conectado');

          return PageRouteBuilder(
            pageBuilder: (_, _, _) =>
                MainScreen(deviceName: deviceName, deviceStatus: deviceStatus),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: Duration(milliseconds: 250),
          );
          // TELA DO PROTOCOLO
        } else if (settings.name == Constants.screenProtocol) {
          return MaterialPageRoute(
            builder: (context) => const ProtocolScreen(),
          );
          // TELA DAS AUTOMAÇÕES
        } else if (settings.name == Constants.screenAutomations) {
          return MaterialPageRoute(
            builder: (context) => const AutomationsScreen(),
          );
          // TELA DE AJUDA
        } else if (settings.name == Constants.screenHelpInitial) {
          return MaterialPageRoute(builder: (context) => const HelpScreen());
          // TELA DE DEMONSTRAÇÂO
        } else if(settings.name == Constants.screenDemonstration) {
          return MaterialPageRoute(builder: (context) => const DemonstrationScreen());
        }
        return null; // Retorna null para rotas não definidas, o que resultará em uma tela de erro padrão.
      },
    );
  }
}

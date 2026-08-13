// Função para rastrear visualizações de tela
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsHelper {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> trackScreenView(String screenName) async {
    await FirebaseAnalytics.instance.logScreenView(screenName: screenName);
  }

  static Future<void> trackLogUser(String userlog) async {
    await analytics.logEvent(
      name: userlog,
      parameters: {'timestamp': DateTime.now().millisecondsSinceEpoch},
    );
  }
}

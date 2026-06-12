// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Virtual Display';

  @override
  String get devicesKnown => 'Known devices';

  @override
  String get speed => 'Velocidade';

  @override
  String get temperature => 'Temperature';

  @override
  String get humidity => 'Umidade';

  @override
  String get voltage => 'Voltage';

  @override
  String get current => 'Current';

  @override
  String get pressure => 'Pressure';

  @override
  String get level => 'Level';

  @override
  String get detector => 'Detector';

  @override
  String get magnetic => 'Magnetic';

  @override
  String get weight => 'Weight';

  @override
  String get other => 'Other';

  @override
  String get gps => 'GPS';

  @override
  String get led => 'LED';

  @override
  String get buzzer => 'Buzzer';

  @override
  String get alarm => 'Alarm';

  @override
  String get configAdvanced => 'Configuration of advanced connection';

  @override
  String get comProtocol => 'Communication protocol';

  @override
  String get protocol => 'Protocolo de comunicação';

  @override
  String get versionProtocol => 'Versão: ';

  @override
  String get formatJson => 'Usar formato JSON';

  @override
  String get titleHowToSendProtocol => 'Como enviar uma mensagem para o app';

  @override
  String get bodyPageOneHowToSendProtocol => 'Deve-se utilizar 2 tópicos para envio de dados...';
}

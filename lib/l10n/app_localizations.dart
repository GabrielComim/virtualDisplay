import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'Virtual Display'**
  String get appTitle;

  /// No description provided for @devicesKnown.
  ///
  /// In pt, this message translates to:
  /// **'Dispositivos conhecidos'**
  String get devicesKnown;

  /// No description provided for @failConnectionMqtt.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao conectar ao broker MQTT'**
  String get failConnectionMqtt;

  /// No description provided for @successConnection.
  ///
  /// In pt, this message translates to:
  /// **'Conectado com sucesso'**
  String get successConnection;

  /// No description provided for @labelIconRefresh.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar conexões'**
  String get labelIconRefresh;

  /// No description provided for @labelIconAdd.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar broker'**
  String get labelIconAdd;

  /// No description provided for @connected.
  ///
  /// In pt, this message translates to:
  /// **'Conectado'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In pt, this message translates to:
  /// **'Desconectado'**
  String get disconnected;

  /// No description provided for @selected.
  ///
  /// In pt, this message translates to:
  /// **'selecionado(s)'**
  String get selected;

  /// No description provided for @edit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get delete;

  /// No description provided for @speed.
  ///
  /// In pt, this message translates to:
  /// **'Velocidade'**
  String get speed;

  /// No description provided for @temperature.
  ///
  /// In pt, this message translates to:
  /// **'Temperatura'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In pt, this message translates to:
  /// **'Umidade'**
  String get humidity;

  /// No description provided for @voltage.
  ///
  /// In pt, this message translates to:
  /// **'Voltagem'**
  String get voltage;

  /// No description provided for @current.
  ///
  /// In pt, this message translates to:
  /// **'Corrente'**
  String get current;

  /// No description provided for @pressure.
  ///
  /// In pt, this message translates to:
  /// **'Pressão'**
  String get pressure;

  /// No description provided for @level.
  ///
  /// In pt, this message translates to:
  /// **'Nível'**
  String get level;

  /// No description provided for @detector.
  ///
  /// In pt, this message translates to:
  /// **'Detector'**
  String get detector;

  /// No description provided for @magnetic.
  ///
  /// In pt, this message translates to:
  /// **'Magnético'**
  String get magnetic;

  /// No description provided for @weight.
  ///
  /// In pt, this message translates to:
  /// **'Peso'**
  String get weight;

  /// No description provided for @other.
  ///
  /// In pt, this message translates to:
  /// **'Outro'**
  String get other;

  /// No description provided for @gps.
  ///
  /// In pt, this message translates to:
  /// **'GPS'**
  String get gps;

  /// No description provided for @led.
  ///
  /// In pt, this message translates to:
  /// **'LED'**
  String get led;

  /// No description provided for @buzzer.
  ///
  /// In pt, this message translates to:
  /// **'Buzzer'**
  String get buzzer;

  /// No description provided for @alarm.
  ///
  /// In pt, this message translates to:
  /// **'Alarme'**
  String get alarm;

  /// No description provided for @tabDashboard.
  ///
  /// In pt, this message translates to:
  /// **'Dashboard'**
  String get tabDashboard;

  /// No description provided for @tabGraphics.
  ///
  /// In pt, this message translates to:
  /// **'Gráficos'**
  String get tabGraphics;

  /// No description provided for @configAdvanced.
  ///
  /// In pt, this message translates to:
  /// **'Configurações de conexão avançadas'**
  String get configAdvanced;

  /// No description provided for @comProtocol.
  ///
  /// In pt, this message translates to:
  /// **'Protocolo de comunicação'**
  String get comProtocol;

  /// No description provided for @mqttBroker.
  ///
  /// In pt, this message translates to:
  /// **'Broker: '**
  String get mqttBroker;

  /// No description provided for @credentialName.
  ///
  /// In pt, this message translates to:
  /// **'Nome: '**
  String get credentialName;

  /// No description provided for @credentialPassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha: '**
  String get credentialPassword;

  /// No description provided for @tls.
  ///
  /// In pt, this message translates to:
  /// **'Com TLS: '**
  String get tls;

  /// No description provided for @usernameBroker.
  ///
  /// In pt, this message translates to:
  /// **'Nome do usuário no broker'**
  String get usernameBroker;

  /// No description provided for @passwordBroker.
  ///
  /// In pt, this message translates to:
  /// **'Senha do usuário no broker'**
  String get passwordBroker;

  /// No description provided for @tlsSecure.
  ///
  /// In pt, this message translates to:
  /// **'Com certificado de segurança (sim ou não)'**
  String get tlsSecure;

  /// No description provided for @ok.
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @save.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get save;

  /// No description provided for @exportCSV.
  ///
  /// In pt, this message translates to:
  /// **'Exportar gráficos como CSV'**
  String get exportCSV;

  /// No description provided for @protocol.
  ///
  /// In pt, this message translates to:
  /// **'Protocolo de comunicação'**
  String get protocol;

  /// No description provided for @versionProtocol.
  ///
  /// In pt, this message translates to:
  /// **'Versão: '**
  String get versionProtocol;

  /// No description provided for @formatJson.
  ///
  /// In pt, this message translates to:
  /// **'Usar formato JSON'**
  String get formatJson;

  /// No description provided for @example.
  ///
  /// In pt, this message translates to:
  /// **'Exemplo:'**
  String get example;

  /// No description provided for @configTopic.
  ///
  /// In pt, this message translates to:
  /// **'Tópico para configuração:'**
  String get configTopic;

  /// No description provided for @dataTopic.
  ///
  /// In pt, this message translates to:
  /// **'Tópico para dados:'**
  String get dataTopic;

  /// No description provided for @titleHowToSendProtocol.
  ///
  /// In pt, this message translates to:
  /// **'Como enviar uma mensagem para o app'**
  String get titleHowToSendProtocol;

  /// No description provided for @titleBodyPageHowToSendProtocol.
  ///
  /// In pt, this message translates to:
  /// **'Tópico para configuração'**
  String get titleBodyPageHowToSendProtocol;

  /// No description provided for @bodyPageOneHowToSendProtocol.
  ///
  /// In pt, this message translates to:
  /// **'2 tópicos para envio de dados. \n * Um tópico para configuração da tela.\n * O segundo tópico é para atualizar os dados.\n\nExiste 3 tipos de dados: \n * number \n * bool \n * string. \nOs dados numéricos possuem mais configurações do que dados booleanos e strings. Os valores min e max informam os limites dos valor. E history indica se deve ser gerado gráfico ou não.'**
  String get bodyPageOneHowToSendProtocol;

  /// No description provided for @bodyPageTwoHowToSendProtocol.
  ///
  /// In pt, this message translates to:
  /// **'É através deste tópico que será informado quantos itens o usuário quer renderizar na tela, além dos detalhes do item. \n\n Tópico MQTT: virtualDisplay/response_config'**
  String get bodyPageTwoHowToSendProtocol;

  /// No description provided for @bodyPageTwoHowToSendProtocolTwo.
  ///
  /// In pt, this message translates to:
  /// **'Siga acrescentando este modelo de chaves com cada item que se deseja configurar.'**
  String get bodyPageTwoHowToSendProtocolTwo;

  /// No description provided for @bodyPageThreeHowToSendProtocol.
  ///
  /// In pt, this message translates to:
  /// **'Os valores min e max não são obrigatórios.'**
  String get bodyPageThreeHowToSendProtocol;

  /// No description provided for @bodyPageFourHowToSendProtocol.
  ///
  /// In pt, this message translates to:
  /// **'Escolha um ID existente para que a interface consiga classificar seu item de alguma forma. \n\n IDs existentes: \n Estes IDs são usados para tipos de dados numéricos:\n'**
  String get bodyPageFourHowToSendProtocol;

  /// No description provided for @bodyPageFourHowToSendProtocolTwo.
  ///
  /// In pt, this message translates to:
  /// **'Estes IDs são utilizados para tipos de dados Booleanos.'**
  String get bodyPageFourHowToSendProtocolTwo;

  /// No description provided for @bodyPageFourHowToSendProtocolThree.
  ///
  /// In pt, this message translates to:
  /// **'Este ID é utilizado para tipo de dados String'**
  String get bodyPageFourHowToSendProtocolThree;

  /// No description provided for @bodyPageFiveHowToSendProtocol.
  ///
  /// In pt, this message translates to:
  /// **'É neste tópico que o valor do item será atualizado.\n'**
  String get bodyPageFiveHowToSendProtocol;

  /// No description provided for @bodyPageFiveHowToSendProtocolTwo.
  ///
  /// In pt, this message translates to:
  /// **'Se for um sensor de temperatura, deve-se colocar o título do item e o valor. Algo como:\n'**
  String get bodyPageFiveHowToSendProtocolTwo;

  /// No description provided for @bodyPageSixHowToSendProtocol.
  ///
  /// In pt, this message translates to:
  /// **'Inscreva-se nos tópicos:\n  * virtualDisplay/request_config\n * virtualDisplay/config_ack\n\nNo primeiro tópico se você receber getConfig quer dizer que o app não possui configurações válidas. No segundo tópico indica que recebeu as configurações.'**
  String get bodyPageSixHowToSendProtocol;

  /// No description provided for @bodyPageSixHowToSendProtocolTwo.
  ///
  /// In pt, this message translates to:
  /// **'Nestes tópicos é possível ler a alteração de estado de botões. Lê-se \"true\" ou \"false\".\n\n Para mais informações e um exemplo completo de um firmware usando ESP32, acesse o link: '**
  String get bodyPageSixHowToSendProtocolTwo;

  /// No description provided for @linkGithubExample.
  ///
  /// In pt, this message translates to:
  /// **'https://github.com/GabrielComim/virtualDisplayDevice.git'**
  String get linkGithubExample;

  /// No description provided for @noData.
  ///
  /// In pt, this message translates to:
  /// **'Sem dados'**
  String get noData;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

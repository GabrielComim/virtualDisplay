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
  String get tabDashboard => 'Dashboard';

  @override
  String get tabGraphics => 'Gráficos';

  @override
  String get configAdvanced => 'Configuration of advanced connection';

  @override
  String get comProtocol => 'Communication protocol';

  @override
  String get mqttBroker => 'Broker: ';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Salvar';

  @override
  String get protocol => 'Protocolo de comunicação';

  @override
  String get versionProtocol => 'Versão: ';

  @override
  String get formatJson => 'Usar formato JSON';

  @override
  String get example => 'Exemplo:';

  @override
  String get configTopic => 'Tópico para configuração:';

  @override
  String get dataTopic => 'Tópico para dados:';

  @override
  String get titleHowToSendProtocol => 'Como enviar uma mensagem para o app';

  @override
  String get titleBodyPageHowToSendProtocol => 'Tópico para configuração';

  @override
  String get bodyPageOneHowToSendProtocol => 'Deve-se utilizar 2 tópicos para envio de dados...';

  @override
  String get bodyPageTwoHowToSendProtocol => 'É através deste tópico que será informado quantos itens o usuário quer renderizar na tela, além dos detalhes do item. \n\n Tópico MQTT: virtualDisplay/config';

  @override
  String get bodyPageTwoHowToSendProtocolTwo => 'Siga acrescentando este modelo de chaves com cada item que se deseja configurar. Quantidade máxima de itens permitidos são 20 itens.';

  @override
  String get bodyPageThreeHowToSendProtocol => 'Os valores min e max não são obrigatórios.';

  @override
  String get bodyPageFourHowToSendProtocol => 'Escolha um ID existente para que a interface consiga classificar seu item de alguma forma. \n\n IDs existentes: \n Estes IDs são usados para tipos de dados numéricos:\n';

  @override
  String get bodyPageFourHowToSendProtocolTwo => 'Estes IDs são utilizados para tipos de dados Booleanos.';

  @override
  String get bodyPageFourHowToSendProtocolThree => 'Este ID é utilizado para tipo de dados String';

  @override
  String get bodyPageFiveHowToSendProtocol => 'É neste tópico que o valor do item será atualizado.\n Exemplo: Se for um sensor de temperatura, neste item será informado apenas o valor, algo como: 25,5.';

  @override
  String get bodyPageFiveHowToSendProtocolTwo => 'Seguir até item20\n';

  @override
  String get bodyPageSixHowToSendProtocol => 'Inscreva-se nos tópicos:\n   virtualDisplay/waiting_config\n\nNeste tópico se você receber true quer dizer que o app está aguardando o envio das configurações. False quer dizer que ele possui configurações válidas.';

  @override
  String get bodyPageSixHowToSendProtocolTwo => 'Nestes tópicos é possível ler a alteração de estado de botões. Lê-se \"ON\" ou \"OFF\".\n\n Para mais informações, acesse o link: ';
}

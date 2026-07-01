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
  String get failConnectionMqtt => 'Falha ao conectar ao broker MQTT';

  @override
  String get successConnection => 'Conectado com sucesso';

  @override
  String get labelIconRefresh => 'Atualizar conexões';

  @override
  String get labelIconAdd => 'Adicionar broker';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String get selected => 'selecionado(s)';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Excluir';

  @override
  String get type => 'Tipo';

  @override
  String get enable => 'Habilitado';

  @override
  String get action => 'Ação';

  @override
  String get triggerConfig => 'Configuração do gatilho';

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
  String get credentialName => 'Nome: ';

  @override
  String get credentialPassword => 'Senha: ';

  @override
  String get tls => 'Com TLS: ';

  @override
  String get usernameBroker => 'Nome do usuário no broker';

  @override
  String get passwordBroker => 'Senha do usuário no broker';

  @override
  String get tlsSecure => 'Com certificado de segurança (sim ou não)';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Salvar';

  @override
  String get exportCSV => 'Exportar gráficos como CSV';

  @override
  String get automations => 'Automações';

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
  String get bodyPageTwoHowToSendProtocol => 'É através deste tópico que será informado quantos itens o usuário quer renderizar na tela, além dos detalhes do item. \n\n Tópico MQTT: virtualDisplay/response_config';

  @override
  String get bodyPageTwoHowToSendProtocolTwo => 'Siga acrescentando este modelo de chaves com cada item que se deseja configurar.';

  @override
  String get bodyPageThreeHowToSendProtocol => 'Os valores min e max não são obrigatórios.';

  @override
  String get bodyPageFourHowToSendProtocol => 'Escolha um ID existente para que a interface consiga classificar seu item de alguma forma. \n\n IDs existentes: \n Estes IDs são usados para tipos de dados numéricos:\n';

  @override
  String get bodyPageFourHowToSendProtocolTwo => 'Estes IDs são utilizados para tipos de dados Booleanos.';

  @override
  String get bodyPageFourHowToSendProtocolThree => 'Este ID é utilizado para tipo de dados String';

  @override
  String get bodyPageFiveHowToSendProtocol => 'É neste tópico que o valor do item será atualizado.\n';

  @override
  String get bodyPageFiveHowToSendProtocolTwo => 'Se for um sensor de temperatura, deve-se colocar o título do item e o valor. Algo como:\n';

  @override
  String get bodyPageSixHowToSendProtocol => 'Inscreva-se nos tópicos:\n  * virtualDisplay/request_config\n * virtualDisplay/config_ack\n\nNo primeiro tópico se você receber getConfig quer dizer que o app não possui configurações válidas. No segundo tópico indica que recebeu as configurações.';

  @override
  String get bodyPageSixHowToSendProtocolTwo => 'Nestes tópicos é possível ler a alteração de estado de botões. Lê-se \"true\" ou \"false\".\n\n Para mais informações e um exemplo completo de um firmware usando ESP32, acesse o link: ';

  @override
  String get linkGithubExample => 'https://github.com/GabrielComim/virtualDisplayDevice.git';

  @override
  String get addAutomation => 'Adicionar automação';

  @override
  String get oneShot => 'Uma vez';

  @override
  String get periodic => 'Periódico';

  @override
  String get logical => 'Lógico';

  @override
  String get name => 'Nome';

  @override
  String get publish => 'Publicação';

  @override
  String get noData => 'Sem dados';
}

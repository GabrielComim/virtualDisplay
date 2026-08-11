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
  String get noDevicesFound => 'Nenhum dispositivo configurado. \nEnvie a configuração para o broker novamente no tópico:\n virtualDisplay/response_config';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String get modeDemonstration => 'Modo de demonstração, sem interação';

  @override
  String get selected => 'selecionado(s)';

  @override
  String get edit => 'Editar';

  @override
  String get feedback => 'Feedback';

  @override
  String get helpInitial => 'Ajuda inicial';

  @override
  String get questionFeedback => 'O que esperava encontrar no app e não encontrou?';

  @override
  String get send => 'Enviar';

  @override
  String get demontration => 'Demonstração';

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
  String get nextExecution => 'Próx. execução';

  @override
  String get withoutExecution => 'Sem novas execuções';

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
  String get tabMessages => 'Mensagens';

  @override
  String get noMessages => 'Nenhuma mensagem recebida';

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
  String get exportCSVLog => 'Exportar log';

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
  String get bodyPageSixHowToSendProtocolTwo => 'Nestes tópicos é possível ler a alteração de estado de botões. Lê-se \"true\" ou \"false\".\nEm seu dispositivo ao receber algo nestes tópicos confirme para que o app altere o estado, para isto retorne o estado no tópico: \n\nvirtualDisplay/DEVICE_NAME/button_ack/TITLE_ITEM \n\n Para mais informações e um exemplo completo de um firmware usando ESP32, acesse o link: ';

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
  String get topic => 'Tópico:';

  @override
  String get payload => 'Dado:';

  @override
  String get successAutomation => 'Automação atualiza com sucesso';

  @override
  String get deleteSlide => 'Deslize para a esquerda para excluir.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirmExclude => 'Confirma a exclusão?';

  @override
  String get confirmExcludeAgain => 'Deseja realmente excluir isto?';

  @override
  String get actionNotDefined => 'Preencha o campo da ação';

  @override
  String get requiredField => 'Preencha o campo obrigatório.';

  @override
  String get date => 'Data';

  @override
  String get dateAndHour => 'Data e hora:';

  @override
  String get select => 'Selecionar';

  @override
  String get interval => 'Intervalo';

  @override
  String get value => 'Valor';

  @override
  String get oneMinute => 'Um minuto';

  @override
  String get fiveMinutes => 'Cinco minutos';

  @override
  String get tenMinutes => 'Dez minutos';

  @override
  String get fifteenMinutes => 'Quinze minutos';

  @override
  String get thirdMinutes => 'Trinta minutos';

  @override
  String get oneHour => 'Uma hora';

  @override
  String get twoHours => 'Duas horas';

  @override
  String get sixHours => 'Seis horas';

  @override
  String get elevenHours => 'Doze horas';

  @override
  String get oneDay => 'Um dia';

  @override
  String get twoDays => 'Dois dias';

  @override
  String get oneWeek => 'Uma semana';

  @override
  String get oneMonth => 'Um mês';

  @override
  String get retain => 'Retain';

  @override
  String get helpFirstSteps => 'Primeiros passos';

  @override
  String get helpTextOne => 'Para adicionar um broker, primeiro você precisa ter um broker MQTT, ele que fará o intercâmbio das mensagens entre seu dispositivo e os demais.';

  @override
  String get helpTextTwo => 'Procure e crie um broker em seu computador, você precisa pelo menos o HOST/URL aquele código principal que surge ao criar o broker. Exemplo acima mostra a URL criada no Hivemq cloud.';

  @override
  String get helpTextThree => 'Independente do broker, os dois tópicos que você deve utilizar para configurar e atualizar os dados serão os seguintes:';

  @override
  String get helpTopics => 'Tópicos: \n Para configuração: \n * virtualDisplay/response_config \n Para dados: \n * virtualDisplay/DEVICE_NAME/data';

  @override
  String get helpTextThreeSecondPart => 'Para testar, pode enviar as configurações pelo próprio broker, como a imagem a seguir:';

  @override
  String get helpTextFour => 'Para atualizar os dados envie neste formato:';

  @override
  String get helpTextFive => 'Na tela de protocolo (Menu três pontos na tela inicial) existe o link para o github com um exemplo de uso.';

  @override
  String get helpTextSix => 'Em caso de algum problema envie um feedback no botão feedback.';

  @override
  String get noData => 'Sem dados';

  @override
  String get sendSuccess => 'Enviado com sucesso';

  @override
  String get sendFail => 'Falha ao enviar o feedback';

  @override
  String get errorConection => 'Verifique sua conexão com a internet.';
}

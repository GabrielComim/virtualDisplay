import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/theme/text_type.dart';
import 'package:virtual_display/theme/widgets/app_bar_title_custom.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/utils/constants.dart';

class ProtocolScreen extends StatefulWidget {
  const ProtocolScreen({super.key});

  @override
  State<ProtocolScreen> createState() => _ProtocolScreenState();
}

class _ProtocolScreenState extends State<ProtocolScreen> {
  final versionProtocol = 1.0;
  int currentPage = 1; // Página atual do protocolo
  int totalPages = 6; // Total de páginas do protocolo

  Widget _pageViewProtocol(int page) {
    switch (page) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styleText(
              context: context,
              text: AppLocalizations.of(context)!.bodyPageOneHowToSendProtocol,
              type: Constants.bodyText2,
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styleText(
              context: context,
              text: AppLocalizations.of(context)!.configTopic,
              type: Constants.bodyText6,
            ),
            SizedBox(height: 10),
            styleText(
              context: context, 
              text: 
                '''
                  ${AppLocalizations.of(context)!.bodyPageTwoHowToSendProtocol}
                  JSON:
                  {
                    "device":"NOME_DO_DISPOSITIVO",
                    "widgets":[
                    {
                      "id":"NOME_DO_ITEM",
                      "type":"TIPO_DO_ITEM",
                      "title":"TITULO_DO_ITEM",
                      "decimal":"QUANTAS_CASAS_DECIMAIS",
                      "unit":"UNIDADE_DO_VALOR",
                      "min":"VALOR_MINIMO_ACEITAVEL",
                      "max":"VALOR_MAXIMO_ACEITAVEL",
                      "history":"TRUE_OU_FALSE",
                      "value":"1"
                    }
                    ]
                  }
                ${AppLocalizations.of(context)!.bodyPageTwoHowToSendProtocolTwo}
                ''', 
              type: Constants.bodyText2
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styleText(
              context: context,
              text: '''
                ${AppLocalizations.of(context)!.example}
                {
                  "device":"ESP32",
                  "widgets":[
                  {
                    "id":"temperature",
                    "type":"number",
                    "title":"Sensor temp",
                    "decimal":"1",
                    "unit":"celsius",
                    "min":"-55.0",
                    "max":"200",
                    "history":"true",
                    "value:"10"
                  },
                  { 
                    "id":"gps",
                    "type":"bool",
                    "title":"Modulo GPS"
                  }
                  ]
                }
              }
              ''',
              type: Constants.bodyText2,
            ),
            styleText(
              context: context,
              text: AppLocalizations.of(
                context,
              )!.bodyPageThreeHowToSendProtocol,
              type: Constants.bodyText2,
            ),
          ],
        );
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styleText(
              context: context,
              text:
              ''' 
                ${AppLocalizations.of(context)!.bodyPageFourHowToSendProtocol} 
                ${AppLocalizations.of(context)!.temperature} 
                ${AppLocalizations.of(context)!.humidity} 
                ${AppLocalizations.of(context)!.pressure} 
                ${AppLocalizations.of(context)!.voltage} 
                ${AppLocalizations.of(context)!.current} 
                ${AppLocalizations.of(context)!.detector} 
                ${AppLocalizations.of(context)!.magnetic} 
                ${AppLocalizations.of(context)!.weight} 
                ${AppLocalizations.of(context)!.other} 
                ${AppLocalizations.of(context)!.bodyPageFourHowToSendProtocolTwo} 
                ${AppLocalizations.of(context)!.gps} 
                ${AppLocalizations.of(context)!.led} 
                ${AppLocalizations.of(context)!.buzzer} 
                ${AppLocalizations.of(context)!.bodyPageFourHowToSendProtocolThree} 
                ${AppLocalizations.of(context)!.alarm} 
              ''',
              type: Constants.bodyText2,
            ),
          ],
        );
      case 5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styleText(
                context: context,
                text: AppLocalizations.of(context)!.dataTopic,
                type: Constants.bodyText6
            ),
            styleText(
              context: context,
              text: 
              '''${AppLocalizations.of(context)!.bodyPageFiveHowToSendProtocol}
              virtualDisplay/data
             
              ${AppLocalizations.of(context)!.bodyPageFiveHowToSendProtocolTwo}
              ${AppLocalizations.of(context)!.example}
              JSON:
              {
                "device":"ESP32",
                "values": {
                  "Sensor temp.": "60.45"
                }
              }
              ''',
              type: Constants.bodyText2,
            ),
            SizedBox(height: 10,),
          ],
        );
      case 6:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styleText(
              context: context,
              text: 
              '''${AppLocalizations.of(context)!.bodyPageSixHowToSendProtocol}
              
              virtualDisplay/data/button1
              virtualDisplay/data/button2
              virtualDisplay/data/button3
              virtualDisplay/data/button4
              virtualDisplay/data/button5
              
              ${AppLocalizations.of(context)!.bodyPageSixHowToSendProtocolTwo}
              ''',
              type: Constants.bodyText2,
            ),
          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationInitScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitleCustom(
            textScreen: AppLocalizations.of(context)!.appTitle,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  styleText(
                    context: context,
                    text: AppLocalizations.of(context)!.protocol,
                    type: Constants.titleText1,
                  ),
                  SizedBox(height: 10),
                  styleText(
                    context: context,
                    text:
                        '${AppLocalizations.of(context)!.versionProtocol} $versionProtocol',
                    type: Constants.bodyText3,
                  ),
                  styleText(
                    context: context,
                    text: AppLocalizations.of(context)!.formatJson,
                    type: Constants.bodyText3,
                  ),
                  SizedBox(height: 20),
                  styleText(
                    context: context,
                    text: AppLocalizations.of(context)!.titleHowToSendProtocol,
                    type: Constants.titleText4,
                  ),
                  SizedBox(height: 16),
                  // Número da página e botões para navegar entre as páginas do protocolo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(iconSize: 16),
                        onPressed: () {
                          // Lógica para ir para a página anterior do protocolo
                          if (currentPage > 1) {
                            setState(() {
                              currentPage--;
                            });
                          }
                        },
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(iconSize: 16),
                        onPressed: () {
                          // Lógica para ir para a próxima página do protocolo
                          if (currentPage < totalPages) {
                            setState(() {
                              currentPage++;
                            });
                          }
                        },
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                      SizedBox(width: 20),
                      Text('$currentPage / $totalPages'),
                      SizedBox(width: 16),
                    ],
                  ),
                  SizedBox(height: 20),
                  _pageViewProtocol(currentPage),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/theme/text_type.dart';
import 'package:virtual_display/theme/widgets/app_bar_title_custom.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/utils/constants.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  int currentPage = 1; // Página atual do protocolo
  int totalPages = 4; // Total de páginas do protocolo

  Widget _pageViewProtocol(int page) {
    switch (page) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: colocar uma imagem
            styleText(
              context: context,
              text: AppLocalizations.of(context)!.helpTextOne,
              type: Constants.bodyText3,
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styleText(
              context: context,
              text: AppLocalizations.of(context)!.helpTextTwo,
              type: Constants.bodyText3,
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styleText(
              context: context,
              text: AppLocalizations.of(context)!.helpTextThree,
              type: Constants.bodyText3,
            ),
            SizedBox(height: 10),
            styleText(
              context: context,
              text: AppLocalizations.of(context)!.helpTopics,
              type: Constants.bodyText4,
            ),
          ],
        );
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styleText(
              context: context,
              text: AppLocalizations.of(context)!.helpTextFour,
              type: Constants.bodyText3,
            ),
            SizedBox(height: 20),
            styleText(
              context: context,
              text: AppLocalizations.of(context)!.helpTextFive,
              type: Constants.bodyText3,
            ),
            SizedBox(height: 20),
            styleText(
              context: context,
              text: AppLocalizations.of(context)!.helpTextSix,
              type: Constants.bodyText3,
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  styleText(
                    context: context,
                    text: AppLocalizations.of(context)!.helpFirstSteps,
                    type: Constants.titleText1,
                  ),
                  SizedBox(height: 10),
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

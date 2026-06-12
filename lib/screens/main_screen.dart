import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/theme/widgets/app_bar_title_custom.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/widgets/cards/cards_conection_device.dart';
import 'package:virtual_display/widgets/cards/cards_dashboard_bool.dart';
import 'package:virtual_display/widgets/cards/cards_dashboard_numeric.dart';
import 'package:virtual_display/widgets/cards/cards_dashboard_string.dart.dart';

class MainScreen extends StatefulWidget {
  final String deviceName; // Nome do dispositivo
  final String deviceStatus; // Indica se o dispositivo está conectado ou não
  final List<String> idCard; // Id do card
  final List<String> typeCard; // Tipo de card a ser exibido
  final List<String> title; // Título do card.
  final List<String> value; // Valor a ser exibido
  final List<String> unit; // Unidade de medida para cada card
  final List<int> minValue; // Valor mínimo para cada card
  final List<int> maxValue; // Valor máximo para cada card

  // Construtor
  const MainScreen({
    super.key,
    required this.deviceName,
    required this.deviceStatus,
    required this.idCard,
    required this.typeCard,
    required this.title,
    required this.value,
    required this.unit,
    required this.minValue,
    required this.maxValue,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationInitScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitleCustom(
            textScreen: AppLocalizations.of(context)!.appTitle,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // TODO: Implementar ação do menu
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // CARD DE CONEXÃO DO DISPOSITIVO
                CardsConectionDevice(
                  deviceName: widget.deviceName,
                  deviceStatus: widget.deviceStatus,
                ),
                SizedBox(height: 16),
                // CARDS DE DASHBOARD
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Cria um grid que se auto ajusta conforme o tamanho de cada card, neste caso conforme o tipo do card.
                      StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children: [
                          for(int index = 0; index < widget.typeCard.length; index++)
                            if (widget.typeCard[index] == Constants.cardTypeNumber)
                              StaggeredGridTile.fit(
                                crossAxisCellCount: 1,
                                child: CardsDashboardNumeric(
                                  title: widget.title[index],
                                  id: widget.idCard[index],
                                  value: int.tryParse(widget.value[index]) ?? 0,
                                  unit: widget.unit[index],
                                  min: widget.minValue[index],
                                  max: widget.maxValue[index],
                                ),
                              )
                            else if (widget.typeCard[index] == Constants.cardTypeBool)
                              StaggeredGridTile.fit(
                                crossAxisCellCount: 1,
                                child: CardsDashboardBool(
                                  title: widget.title[index],
                                  id: widget.idCard[index],
                                  value: widget.value[index] == 'true',
                                ),
                              )
                            else if (widget.typeCard[index] == Constants.cardTypeString)
                              StaggeredGridTile.fit(
                                crossAxisCellCount: 2,
                                child: CardsDashboardString(
                                  id: widget.idCard[index],
                                  title: widget.title[index],
                                  msg: widget.value[index],
                                ),
                              )
                            else 
                              SizedBox.shrink(), // Retorna um widget vazio para tipos de card que não são numéricos
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

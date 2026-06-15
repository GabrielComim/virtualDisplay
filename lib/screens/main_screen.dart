// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/theme/colors.dart';
import 'package:virtual_display/theme/widgets/app_bar_title_custom.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/widgets/buttons/button_more_options.dart';
import 'package:virtual_display/widgets/cards/cards_conection_device.dart';
import 'package:virtual_display/models/cards_dashboard.dart';
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
  List<CardsDashboard> cardsDashboard = [];
  CardsDashboard? draggedCard;

  Widget _dashboardView() {
    return SingleChildScrollView(
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: _buildCards(),
      ),
    );
  }

  Widget _graphicsView() {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.appTitle,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget _buildCardContent(CardsDashboard card) {
    if (card.typeCard == Constants.cardTypeNumber) {
      return CardsDashboardNumeric(
        title: card.title,
        id: card.id,
        value: int.tryParse(card.value) ?? 0,
        unit: card.unit,
        min: card.minValue,
        max: card.maxValue,
      );
    }

    if (card.typeCard == Constants.cardTypeBool) {
      return CardsDashboardBool(
        title: card.title,
        id: card.id,
        value: card.value == 'true',
      );
    }

    return CardsDashboardString(
      id: card.id,
      title: card.title,
      msg: card.value,
    );
  }

  List<Widget> _buildCards() {
    return cardsDashboard.map((card) {
      return StaggeredGridTile.fit(
        key: ValueKey(card.id),
        crossAxisCellCount: card.typeCard == Constants.cardTypeString ? 2 : 1,
        child: _buildDragTarget(card),
      );
    }).toList();
  }

  Widget _buildDragTarget(CardsDashboard card) {
    return DragTarget<CardsDashboard>(
      onAcceptWithDetails: (details) {
        final origem = cardsDashboard.indexOf(details.data);
        final destino = cardsDashboard.indexOf(card);

        if (origem == destino) return;

        setState(() {
          final item = cardsDashboard.removeAt(origem);
          cardsDashboard.insert(destino, item);
        });
      },

      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: isHovering
                ? Border.all(
                    color: ColorScheme.of(context).secondary,
                    style: BorderStyle.solid,
                  )
                : null,
          ),

          child: LongPressDraggable<CardsDashboard>(
            data: card,

            feedback: Material(
              elevation: 8,
              child: SizedBox(width: 200, child: _buildCardContent(card)),
            ),

            childWhenDragging: Opacity(
              opacity: 0.3,
              child: _buildCardContent(card),
            ),

            child: _buildCardContent(card),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Inicializa a lista de cards do dashboard com os dados recebidos
    cardsDashboard = List.generate(
      widget.idCard.length,
      (index) => CardsDashboard(
        id: widget.idCard[index],
        typeCard: widget.typeCard[index],
        title: widget.title[index],
        value: widget.value[index],
        unit: widget.unit[index],
        minValue: widget.minValue[index],
        maxValue: widget.maxValue[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationInitScreen(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: AppBarTitleCustom(
              textScreen: AppLocalizations.of(context)!.appTitle,
            ),
            actions: [
              buttonMoreOptions(context),
            ],
            // bottom: TabBar(
            //   labelColor: ColorScheme.of(context).secondary,
            //   tabs: [
            //     Tab(text: AppLocalizations.of(context)!.tabDashboard),
            //     Tab(text: AppLocalizations.of(context)!.tabGraphics),
            //   ],
            // ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // CARD DE CONEXÃO DO DISPOSITIVO
                CardsConectionDevice(
                  deviceName: widget.deviceName,
                  deviceStatus: widget.deviceStatus,
                ),
                SizedBox(height: 16),
                // CARDS DE DASHBOARD
                Expanded(
                  child: TabBarView(
                    children: [
                      // Cria um grid que se auto ajusta conforme o tamanho de cada card, neste caso conforme o tipo do card.
                      _dashboardView(), 
                      _graphicsView()],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Material(
              // color: Theme.of(context).colorScheme.surface,
              color: AppColors.cardConnectionBackground,
              child: TabBar(
                labelColor: ColorScheme.of(context).secondary,
                tabs: [
                  Tab(
                    icon: Icon(Icons.dashboard),
                    text: AppLocalizations.of(context)!.tabDashboard,
                  ),
                  Tab(
                    icon: Icon(Icons.show_chart),
                    text: AppLocalizations.of(context)!.tabGraphics,
                  ),
                ]
              )
            ),
          ),
        ),
      ),
    );
  }
}

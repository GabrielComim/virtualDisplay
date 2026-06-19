import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/viewModel/mqtt_publish_vm.dart';
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

  // Construtor
  const MainScreen({
    super.key,
    required this.deviceName,
    required this.deviceStatus,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
    final MqttPublishVm mqttPublish = context.read<MqttPublishVm>();
    // Envia requisição das configurações iniciais
    mqttPublish.requestConfig();
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
            actions: [buttonMoreOptions(context)],
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
                Expanded(
                  child: TabBarView(
                    children: [
                      // CARDS DE DASHBOARD
                      // Cria um grid que se auto ajusta conforme o tamanho de cada card, neste caso conforme o tipo do card.
                      _dashboardView(),
                      // Aba com os gráficos, que ainda não foi implementada, mas já está estruturada para receber os gráficos futuramente.
                      _graphicsView(),
                    ],
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dashboardView() {
    return SingleChildScrollView(
      child: Consumer<DashboardViewmodel>(
        builder: (context, vm, child) {
          return StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: _buildCards(vm.cards),
          );
        },
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
    if (card.type == Constants.cardTypeNumber) {
      return CardsDashboardNumeric(
        title: card.title,
        id: card.id,
        value: int.tryParse(card.value) ?? 0,
        unit: card.unit,
        min: card.min,
        max: card.max,
      );
    }

    if (card.type == Constants.cardTypeBool) {
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

  List<Widget> _buildCards(List<dynamic> cards) {
    return cards.map((card) {
      return StaggeredGridTile.fit(
        key: ValueKey(card.title),
        crossAxisCellCount: card.type == Constants.cardTypeString ? 2 : 1,
        child: _buildDragTarget(card),
      );
    }).toList();
  }

  Widget _buildDragTarget(CardsDashboard card) {
    return DragTarget<CardsDashboard>(
      onAcceptWithDetails: (details) {
        final viewModel = context.read<DashboardViewmodel>();
        final origem = viewModel.cards.indexOf(details.data);
        final destino = viewModel.cards.indexOf(card);

        if (origem == destino) return;

        viewModel.moveCard(origem, destino);
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
}

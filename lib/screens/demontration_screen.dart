import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/chart_data.dart';
import 'package:virtual_display/models/chart_sample.dart';
import 'package:virtual_display/services/mqtt/mqtt_message_processor.dart';
import 'package:virtual_display/viewModel/dashboard_viewmodel.dart';
import 'package:virtual_display/viewModel/devices_viewmodel.dart';
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
import 'package:virtual_display/widgets/item_line_chart.dart';

class DemonstrationScreen extends StatefulWidget {
  const DemonstrationScreen({super.key});

  @override
  State<DemonstrationScreen> createState() => _DemonstrationScreenState();
}

class _DemonstrationScreenState extends State<DemonstrationScreen> {
  final int brokerId = 99; // ID do broker fictício para demonstração
  final String deviceName =
      Constants.jsonConfigTestDeviceName; // Nome do dispositivo
  final String deviceStatus =
      'Conectado'; // Indica se o dispositivo está conectado ou não
  late final MqttMessageProcessor
  _demoProcessor; // Cria a instância que será usada para iniciar e parar a aplicação de demonstração

  @override
  void initState() {
    super.initState();
    // Cria a instância para o modo demonstração
    // Busca o valor no provider
    final devicesViewModel = context.read<DevicesViewModel>();
    final MqttPublishVm mqttPublishViewModel = context.read<MqttPublishVm>();
    final DashboardViewmodel dashboardViewmodel = context
        .read<DashboardViewmodel>();

    _demoProcessor = MqttMessageProcessor(
      devicesViewModel,
      mqttPublishViewModel,
      dashboardViewmodel,
      brokerId,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _demoProcessor.initDemonstrationMode();
    });
  }

  @override
  void dispose() {
    _demoProcessor.stopDemonstrationMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationInitScreen(),
      child: DefaultTabController(
        length: Constants.QUANT_TABS_MAIN_SCREEN,
        child: Scaffold(
          appBar: AppBar(
            title: AppBarTitleCustom(
              textScreen:
                  "${AppLocalizations.of(context)!.appTitle} - ${AppLocalizations.of(context)!.modeDemonstration}",
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // CARD DE CONEXÃO DO DISPOSITIVO
                CardsConectionDevice(
                  deviceName: deviceName,
                  deviceStatus: deviceStatus,
                ),
                SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    children: [
                      // CARDS DE DASHBOARD
                      _dashboardView(),
                      // GRÁFICOS
                      _graphicsView(),
                      // LOG DE MENSAGENS
                      _messagesView(),
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
                  Tab(
                    icon: Icon(Icons.message),
                    text: AppLocalizations.of(context)!.tabMessages,
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
            children: _buildCards(vm.getCards(brokerId, deviceName)),
          );
        },
      ),
    );
  }

  Widget _graphicsView() {
    return SingleChildScrollView(
      child: Consumer<DashboardViewmodel>(
        builder: (context, vm, child) {
          final entries = vm.history.entries.toList();
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: entries.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final entry = entries[index];
              final key = entry.key;
              final samples = entry.value.samples;
              final card = vm.cards.firstWhere(
                (c) => c.title == key,
                orElse: () => CardsDashboard(
                  id: '',
                  brokerId: brokerId,
                  deviceName: deviceName,
                  type: '',
                  title: key,
                  value: '',
                ),
              );
              // Este tipo não tem gráfico
              if (card.type == Constants.cardTypeString) {
                return const SizedBox.shrink();
              }

              // Tipo booleano vira 0 e 1
              final processedSamples = samples.map((s) {
                if (card.type == Constants.cardTypeBool) {
                  log('value: ${s.value}');
                  return ChartSample(timestamp: s.timestamp, value: s.value);
                }
                return s;
              }).toList();

              return ItemLineChart(
                chartData: ChartData(
                  title: key,
                  unit: card.unit ?? '',
                  samples: processedSamples,
                ),
                brokerId: brokerId,
                deviceName: deviceName,
              );
            },
          );
        },
      ),
    );
  }

  Widget _messagesView() {
    return Consumer<DashboardViewmodel>(
      builder: (context, vm, child) {
        final messages = vm.getMessageHistory(
          brokerId,
          deviceName,
        );
        if (messages.isEmpty) {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.noMessages,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Botão para exportar mensagens CSV
            buttonExportCsvMessages(
              context,
              brokerId,
              deviceName,
              messages,
            ),
            // Lista de mensagens
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ListTile(
                    title: Text(message.title),
                    subtitle: Text(message.value),
                    trailing: Text(
                      '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}:${message.time.second.toString().padLeft(2, '0')}',
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // Aqui onde realmente acontece as coisas nesta tela
  Widget _buildCardContent(CardsDashboard card) {
    if (card.type == Constants.cardTypeNumber) {
      return CardsDashboardNumeric(
        title: card.title,
        id: card.id,
        value: double.tryParse(card.value) ?? 0,
        decimal: card.decimal,
        unit: card.unit,
        min: card.min,
        max: card.max,
      );
    }

    if (card.type == Constants.cardTypeBool) {
      return CardsDashboardBool(
        deviceName: deviceName,
        title: card.title,
        id: card.id,
        value: card.value == 'true',
        activeButton: true,
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
        key: ValueKey('${card.brokerId}_${card.deviceName}_${card.title}'),
        crossAxisCellCount: card.type == Constants.cardTypeString ? 2 : 1,
        child: _buildDragTarget(card),
      );
    }).toList();
  }

  // Drag target permite o arrastar e organizar os cards
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

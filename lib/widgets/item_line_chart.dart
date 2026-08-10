import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/chart_data.dart';
import 'package:virtual_display/models/chart_sample.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/widgets/buttons/button_more_options.dart';

class ItemLineChart extends StatelessWidget {
  final ChartData chartData;
  final int brokerId;
  final String deviceName;

  // Construtor
  const ItemLineChart({
    super.key,
    required this.chartData,
    required this.brokerId,
    required this.deviceName,
  });

  List<FlSpot> _buildSpots(List<ChartSample> samples) {
    return samples.map<FlSpot>((sample) {
      // Eixo x - Tempo relativo em segundos
      final x = sample.timestamp.millisecondsSinceEpoch / 1000.0;

      return FlSpot(x, sample.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (chartData.samples.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.noData));
    }

    // Janela de tempo para o eixo x do gráfico
    final now = DateTime.now();
    final startTime = now.subtract(Constants.timeWindow);
    final visibleSamples = chartData.samples
        .where((sample) => sample.timestamp.isAfter(startTime))
        .toList();
    // Cria os pontos do gráfico a partir das amostras visíveis
    final spots = _buildSpots(visibleSamples);

    // Converte a unidade para forma correta de apresentar no gráfico
    // final unit = _convertUnitToGraphic(chartData.unit);

    return Column(
      children: [
        // Título do fráfico
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(chartData.title),
            SizedBox(width: 10),
            buttonMoreOptionsMainScreen(
              context,
              chartData,
              brokerId,
              deviceName,
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //     minimumSize: Size(30,40),
            //     shadowColor: ColorScheme.of(context).secondary,
            //     backgroundColor: Colors.transparent,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            //   child: Icon(Icons.more_vert),
            //   onPressed: () {
            //   },
            // ),
          ],
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: SizedBox(
              height: 190,
              child: LineChart(
                LineChartData(
                  minX: startTime.millisecondsSinceEpoch / 1000.0,
                  maxX: now.millisecondsSinceEpoch / 1000.0,
                  gridData: FlGridData(show: true),
                  // VALORES E UNIDADES NO GRÁFICO
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        interval:
                            10, // Intervalo entre os valores do eixo horizontal
                        reservedSize:
                            20, // Área reservada para os valores do eixo.
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value - (startTime.millisecondsSinceEpoch / 1000.0) <
                                  Constants.edgeMarginChart ||
                              value - (now.millisecondsSinceEpoch / 1000.0) >
                                  - Constants.edgeMarginChart) {
                            return SizedBox.shrink(); // Retorna um widget vazio para não mostrar o título
                          }
                          final date = DateTime.fromMicrosecondsSinceEpoch(
                            (value * 1000000).toInt(),
                          );
                          final time =
                              '${date.hour.toString().padLeft(2, '0')}:'
                              '${date.minute.toString().padLeft(2, '0')}:'
                              '${date.second.toString().padLeft(2, '0')}';
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(time, style: TextStyle(fontSize: 8)),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 30,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              '${value.toStringAsFixed(0)} ${chartData.unit}',
                              style: TextStyle(fontSize: 8),
                            ),
                          );
                        },
                      ),
                    ),
                    // Não mostra valores no eixo y direito
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    // Não mostra valores no eixo x superior
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: false,
                      dotData: FlDotData(show: false),
                      barWidth: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

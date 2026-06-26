import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/chart_data.dart';
import 'package:virtual_display/models/chart_sample.dart';
import 'package:virtual_display/widgets/buttons/button_more_options.dart';

class ItemLineChart extends StatelessWidget {
  final ChartData chartData;

  // Construtor
  const ItemLineChart({super.key, required this.chartData});

  List<FlSpot> _buildSpots(List<ChartSample> samples) {
    final baseTime = samples.first.timestamp;

    return samples.asMap().entries.map((entry) {
      // final index = entry.key;
      final sample = entry.value;

      // Eixo x - Tempo relativo em segundos
      final x = sample.timestamp.difference(baseTime).inSeconds.toDouble();

      return FlSpot(x, sample.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (chartData.samples.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.noData));
    }

    final spots = _buildSpots(chartData.samples);

    return Column(
      children: [
        // Título do fráfico
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(chartData.title),
            SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                minimumSize: Size(30,40),
                shadowColor: ColorScheme.of(context).secondary,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Icon(Icons.more_vert),
              onPressed: () {
                buttonMoreOptionsMainScreen(context);
              },
            ),
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
                  gridData: FlGridData(show: true),
                  // VALORES E UNIDADES NO GRÁFICO
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()} s',
                            style: TextStyle(fontSize: 8),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toStringAsFixed(0)} ${chartData.unit}',
                            style: TextStyle(fontSize: 8),
                          );
                        },
                      ),
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

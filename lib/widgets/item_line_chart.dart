import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/models/item_sample.dart';

class ItemLineChart extends StatelessWidget {
  final String title;
  final String unit;
  final List<ItemSample> samples;

  // Construtor
  const ItemLineChart({super.key, required this.title, required this.unit, required this.samples});

  List<FlSpot> _buildSpots(List<ItemSample> samples) {
    final baseTime = samples.first.timestamp;

    return samples.asMap().entries.map((entry) {
      final index = entry.key;
      final sample = entry.value;

      // Eixo x - Tempo relativo em segundos
      final x = sample.timestamp.difference(baseTime).inSeconds.toDouble();

      return FlSpot(x, sample.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (samples.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.noData));
    }

    final spots = _buildSpots(samples);

    return Column(
      children: [
        // Título do fráfico
        Text(title),
        SizedBox(height: 6),
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
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toStringAsFixed(0)} $unit', style: TextStyle(fontSize: 8),);
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
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

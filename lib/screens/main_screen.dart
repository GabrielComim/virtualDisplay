import 'package:flutter/material.dart';
import 'package:virtual_display/l10n/app_localizations.dart';
import 'package:virtual_display/theme/widgets/app_bar_title_custom.dart';
import 'package:virtual_display/theme/widgets/decoration_init_screen.dart';
import 'package:virtual_display/utils/constants.dart';
import 'package:virtual_display/widgets/cards/cards_conection_device.dart';
import 'package:virtual_display/widgets/cards/cards_dashboard_numeric.dart';

class MainScreen extends StatefulWidget {
  final String deviceName;
  final String deviceStatus;
  final int numberOfCards; // Quantidade de dados a serem exibidos no dashboard
  final List<String> typeCard; // Tipo de card a ser exibido
  final List<int> minValue; // Valor mínimo para cada card
  final List<int> maxValue; // Valor máximo para cada card

  // Construtor
  const MainScreen({
    super.key,
    required this.deviceName,
    required this.deviceStatus,
    required this.numberOfCards,
    required this.typeCard,
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
                      GridView.builder(
                        shrinkWrap:
                            true, // Permite que o GridView ocupe apenas o espaço necessário
                        physics:
                            NeverScrollableScrollPhysics(), // Desativa a rolagem do GridView para evitar conflitos com a rolagem da tela principal
                        itemCount: widget
                            .numberOfCards, // Número de cards a serem exibidos
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // Configura o layout do grid
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio:
                              1.2, // Ajusta a proporção dos cards para melhor visualização//
                        ),
                        itemBuilder: (context, index) {
                          // Exibe o tipo de card com base na configuração recebida
                          if (widget.typeCard[index] == (Constants.cardTypeSpeed)) {
                            // Card de velocidade
                            return CardsDashboardNumeric(
                              type: Constants.cardTypeSpeed,
                              value: 120,
                              unit: 'km/h',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else if (widget.typeCard[index] == (Constants.cardTypeTemperature)) {
                            // Card de temperatura
                            return CardsDashboardNumeric(
                              type: Constants.cardTypeTemperature,
                              value: 25,
                              unit: '°C',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else if (widget.typeCard[index] == (Constants.cardTypeHumidity)) {
                            // Card de umidade
                            return CardsDashboardNumeric(
                              type: Constants.cardTypeHumidity,
                              value: 60,
                              unit: '%',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else if (widget.typeCard[index] == (Constants.cardTypeVoltage)) {
                            // Card de voltage
                            return CardsDashboardNumeric(
                              type: Constants.cardTypeVoltage,
                              value: 12,
                              unit: 'V',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else if (widget.typeCard[index] == (Constants.cardTypeCurrent)) {
                            // Card de campo magnético
                            return CardsDashboardNumeric(
                              type: Constants.cardTypeCurrent,
                              value: 50,
                              unit: 'mA',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else if (widget.typeCard[index] == (Constants.cardTypeHumidity)) {
                            // Card de umidade
                            return CardsDashboardNumeric(
                              type: Constants.cardTypeHumidity,
                              value: 60,
                              unit: '%',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else if (widget.typeCard[index] == (Constants.cardTypePressure)) {
                            // Card de pressão
                            return CardsDashboardNumeric(
                              type: Constants.cardTypePressure,
                              value: 101,
                              unit: 'kPa',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else if (widget.typeCard[index] == (Constants.cardTypeMagnetic)) {
                            // Card de campo magnético
                            return CardsDashboardNumeric(
                              type: Constants.cardTypeMagnetic,
                              value: 50,
                              unit: 'mT',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else if (widget.typeCard[index] == (Constants.cardTypeLevel)) {
                            // Card de nível
                            return CardsDashboardNumeric(
                              type: Constants.cardTypeLevel,
                              value: 50,
                              unit: 'mT',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else if (widget.typeCard[index] == (Constants.cardTypeDetector)) {
                            // Card de detector
                            return CardsDashboardNumeric(
                              type: Constants.cardTypeDetector,
                              value: 50,
                              unit: 'mT',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else if (widget.typeCard[index] == (Constants.cardTypeWeight)) {
                            // Card de peso
                            return CardsDashboardNumeric(
                              type: Constants.cardTypeWeight,
                              value: 50,
                              unit: 'kg',
                              min: widget.minValue[index],
                              max: widget.maxValue[index],
                            );
                          } else {
                            // Configurações padrão
                            return Text('Tipo de card não reconhecido');
                          }
                        },
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

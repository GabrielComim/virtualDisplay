class CardsDashboard {
  final String id;
  final String typeCard; // Tipo do card (numérico, booleano, string)
  final String title; // Título do card
  final String value; // Valor a ser exibido
  final String unit; // Unidade de medida para cada card
  final int minValue; // Valor mínimo para cada card
  final int maxValue; // Valor máximo para cada card

  CardsDashboard({
    required this.id,
    required this.typeCard,
    required this.title,
    required this.value,
    required this.unit,
    required this.minValue,
    required this.maxValue,
  });
}
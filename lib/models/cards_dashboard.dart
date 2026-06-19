class CardsDashboard {
  final String id;
  final String type;  // Tipo do card (numérico, booleano, string)
  final String title;     // Título do card
  final String? decimal;   // Quantos valores considerar depois da vírgula
  final String? unit;      // Unidade de medida para cada card
  final int? min;     // Valor mínimo para cada card
  final int? max;     // Valor máximo para cada card
  final bool? history;    // Se deve guardar histórico para criar gráficos
  final String value;     // Valor 

  CardsDashboard({
    required this.id,
    required this.type,
    required this.title,
    this.decimal,
    this.unit,
    this.min,
    this.max,
    this.history,
    required this.value,
  });

  factory CardsDashboard.fromJson(
    Map<String, dynamic> json,
  ) {
    return CardsDashboard(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      decimal: json['decimal'] ?? '',
      unit: json['unit'] ?? '',
      min: json['min'] != null ? double.parse(json['min']).toInt() : null,
      max: json['max'] != null ? double.parse(json['max']).toInt() : null,
      history: json['history'] == true,
      value: json['value'] ?? '',
    );
  }
}
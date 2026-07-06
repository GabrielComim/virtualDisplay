enum OperandType {
  constant,
  card,
}

class LogicalOperand {
  final OperandType type;
  final String? cardId;
  final dynamic value;

  LogicalOperand({
    required this.type,
    this.cardId,
    this.value,
  });
}
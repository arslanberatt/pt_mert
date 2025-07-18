enum TransactionType {
  income('Gelir'),
  expense('Gider');

  final String value;
  const TransactionType(this.value);

  factory TransactionType.fromString(String? typeString) {
    if (typeString == null) return TransactionType.expense;
    return TransactionType.values.firstWhere(
      (e) => e.value == typeString,
      orElse: () => TransactionType.income,
    );
  }
}

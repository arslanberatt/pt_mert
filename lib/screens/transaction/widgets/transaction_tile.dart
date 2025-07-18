import 'package:flutter/material.dart';
import 'package:transaction_repository/transaction_repository.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final Future<bool> Function() onDismiss;

  const TransactionTile({
    super.key,
    required this.transaction,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == 'income';

    return Dismissible(
      key: Key(transaction.transactionId),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.cancel, color: Colors.white),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(transaction.title ?? 'İşlem'),
        trailing: Text(
          "${isIncome ? '+' : '-'}₺${transaction.amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}

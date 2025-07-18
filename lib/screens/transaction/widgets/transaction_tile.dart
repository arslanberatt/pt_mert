import 'package:flutter/material.dart';
import 'package:transaction_repository/transaction_repository.dart';
import 'package:transaction_repository/src/models/transaction_type.dart';

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
    final isIncome = transaction.type == TransactionType.income;
    final icon = isIncome ? Icons.arrow_upward : Icons.arrow_downward;
    final iconColor = isIncome ? Colors.black : Colors.red;

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
        contentPadding: EdgeInsets.all(8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(transaction.title),
        trailing: Text(
          "${isIncome ? '+' : '-'}₺${transaction.amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pt_mert/components/appbar.dart';
import 'package:pt_mert/screens/transaction/widgets/transaction_add_icon.dart';
import 'package:pt_mert/screens/transaction/widgets/transaction_tile.dart';
import 'package:transaction_repository/transaction_repository.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TransactionRepository transactionRepository =
      FirebaseTransactionRepository();
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final data = await transactionRepository.getTransaction();
    setState(() {
      transactions = data.where((t) => t.isActive).toList();
    });
  }

  Future<bool> _cancelTransaction(Transaction transaction) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("İşlemi İptal Et"),
        content: const Text("Bu işlemi iptal etmek istediğine emin misin?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Vazgeç"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Evet"),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final updated = transaction.copyWith(isActive: false);
      await transactionRepository.updateTransaction(updated);
      _loadTransactions();
    }

    return confirmed == true;
  }

  double get totalIncome => transactions
      .where((t) => t.type == "income")
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpenses => transactions
      .where((t) => t.type == "expense")
      .fold(0.0, (sum, t) => sum + t.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(action: TransactionAddWidget()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Özet",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildSummaryCard("Toplam Gelir", totalIncome, Colors.green),
                const SizedBox(width: 12),
                _buildSummaryCard("Toplam Gider", totalExpenses, Colors.red),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "İşlem Geçmişi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: transactions.isEmpty
                  ? const Center(child: Text("Hiç işlem bulunamadı."))
                  : ListView.separated(
                      itemCount: transactions.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, index) {
                        final t = transactions[index];
                        return TransactionTile(
                          transaction: t,
                          onDismiss: () => _cancelTransaction(t),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 4),
            Text(
              "₺${amount.toStringAsFixed(0)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/components/appbar.dart';
import 'package:pt_mert/components/section_title.dart';
import 'package:pt_mert/screens/transaction/widgets/summary_card.dart';
import 'package:pt_mert/screens/transaction/widgets/transaction_add_icon.dart';
import 'package:pt_mert/screens/transaction/widgets/transaction_tile.dart';
import 'package:transaction_repository/transaction_repository.dart';
import 'package:transaction_repository/src/models/transaction_type.dart';
import 'package:pt_mert/blocs/get_transaction_bloc/get_transaction_bloc.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  void didUpdateWidget(covariant TransactionsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    context.read<GetTransactionBloc>().add(GetTransaction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(action: const TransactionAddWidget()),
      body: BlocBuilder<GetTransactionBloc, GetTransactionState>(
        builder: (context, state) {
          if (state is GetTransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetTransactionSuccess) {
            final transactions = state.transaction
                .where((transaction) => transaction.isActive)
                .toList();

            final incomes = transactions
                .where(
                  (transaction) => transaction.type == TransactionType.income,
                )
                .fold(0.0, (sum, transaction) => sum + (transaction.amount));
            final expenses = transactions
                .where(
                  (transaction) => transaction.type == TransactionType.expense,
                )
                .fold(0.0, (sum, transaction) => sum + (transaction.amount));
            final net = incomes - expenses;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(title: "Özet"),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      SummaryCard("Toplam", net, Colors.black, Colors.white),
                      const SizedBox(width: 8),
                      SummaryCard(
                        "Gelir",
                        incomes,
                        Colors.transparent,
                        Colors.black,
                      ),
                      const SizedBox(width: 8),
                      SummaryCard(
                        "Gider",
                        expenses,
                        Colors.grey.shade300,
                        Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SectionTitle(title: "İşlem Geçmişi"),
                  const SizedBox(height: 12),
                  Expanded(
                    child: transactions.isEmpty
                        ? const Center(child: Text("Hiç işlem bulunamadı."))
                        : ListView.separated(
                            itemCount: transactions.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 1),
                            itemBuilder: (_, index) {
                              final transaction = transactions[index];
                              return TransactionTile(
                                transaction: transaction,
                                onDismiss: () =>
                                    _cancelTransaction(transaction),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("İşlemler yüklenemedi."));
          }
        },
      ),
    );
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
      await FirebaseTransactionRepository().updateTransaction(updated);
      context.read<GetTransactionBloc>().add(GetTransaction());
    }

    return confirmed == true;
  }
}

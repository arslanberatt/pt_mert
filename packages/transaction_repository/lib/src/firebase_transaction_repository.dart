import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:transaction_repository/src/models/transaction.dart';
import 'package:transaction_repository/transaction_repository.dart';
import 'package:uuid/uuid.dart';

import 'transaction_repo.dart';

class FirebaseTransactionRepository implements TransactionRepository {
  final transactionsCollection = FirebaseFirestore.instance.collection(
    'transactions',
  );

  @override
  Future<Transaction> createTransaction(Transaction transaction) async {
    try {
      transaction.transactionId = Uuid().v1();
      transaction.createdAt = DateTime.now();

      transactionsCollection
          .doc(transaction.transactionId)
          .set(transaction.toEntity().toDocument());
      return transaction;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Transaction>> getTransaction() {
    try {
      return transactionsCollection.get().then((value) {
        final transactions = value.docs
            .map(
              (e) => Transaction.fromEntity(
                TransactionEntity.fromDocument(e.data()),
              ),
            )
            .toList();

        transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return transactions;
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Transaction> updateTransaction(Transaction transaction) async {
    try {
      await transactionsCollection
          .doc(transaction.transactionId)
          .update(transaction.toEntity().toDocument());
      return transaction;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

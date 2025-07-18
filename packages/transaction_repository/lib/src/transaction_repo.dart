import 'models/models.dart';

abstract class TransactionRepository {
  Future<Transaction> createTransaction(Transaction transaction);

  Future<List<Transaction>> getTransaction();

  Future<Transaction> updateTransaction(Transaction transaction);
}

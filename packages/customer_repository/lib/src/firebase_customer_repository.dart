import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_repository/src/entities/entities.dart';
import 'package:customer_repository/src/models/customer.dart';
import 'package:uuid/uuid.dart';

import 'customer_repo.dart';

class FirebaseCustomerRepository implements CustomerRepository {
  final customersCollection = FirebaseFirestore.instance.collection(
    'customers',
  );
  @override
  Future<Customer> createCustomer(Customer customer) async {
    try {
      customer.customerId = Uuid().v1();
      customer.createdAt = DateTime.now();
      customer.lastTrainingDate = null;

      customersCollection
          .doc(customer.customerId)
          .set(customer.toEntity().toDocument());
      return customer;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Customer>> getCustomer() {
    try {
      return customersCollection.get().then((value) {
        final customers = value.docs
            .map(
              (e) => Customer.fromEntity(CustomerEntity.fromDocument(e.data())),
            )
            .toList();

        customers.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
        return customers;
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Customer> updateCustomer(Customer customer) async {
    try {
      await customersCollection
          .doc(customer.customerId)
          .update(customer.toEntity().toDocument());
      return customer;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

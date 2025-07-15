import 'models/models.dart';

abstract class CustomerRepository {
  Future<Customer> createCustomer(Customer customer);

  Future<List<Customer>> getCustomer();
}

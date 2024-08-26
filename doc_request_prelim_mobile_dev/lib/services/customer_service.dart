import '../models/customer.dart';

class CustomerService {
  final List<Customer> _customers = [];

  void addCustomer(Customer customer) {
    _customers.add(customer);
  }

  List<Customer> getCustomers() {
    return _customers;
  }
}
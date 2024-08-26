import 'package:riverpod/riverpod.dart';
import '../services/document_service.dart';
import '../services/customer_service.dart';
import '../services/document_request_service.dart';
import '../services/global_services.dart';

// Document Service Provider
final documentServiceProvider = Provider<DocumentService>((ref) {
  return GlobalServices.documentService;
});

// Customer Service Provider
final customerServiceProvider = Provider<CustomerService>((ref) {
  return GlobalServices.customerService;
});

// Document Request Service Provider
final documentRequestServiceProvider = Provider<DocumentRequestService>((ref) {
  return GlobalServices.documentRequestService;
});
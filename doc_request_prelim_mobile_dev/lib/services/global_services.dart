import 'document_service.dart';
import 'customer_service.dart';
import 'document_request_service.dart';

class GlobalServices {
  static final DocumentService documentService = DocumentService();
  static final CustomerService customerService = CustomerService();
  static final DocumentRequestService documentRequestService = DocumentRequestService(
    documentService,
    customerService,
  );
}
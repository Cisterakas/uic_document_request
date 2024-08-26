import '../models/document_request.dart';
import '../models/payment.dart';
import 'document_service.dart';
import 'customer_service.dart';

class DocumentRequestService {
  final List<DocumentRequest> _requests = [];
  final List<Payment> _payments = [];
  final DocumentService documentService; // Reference to DocumentService
  final CustomerService customerService;

  DocumentRequestService(this.documentService, this.customerService);

  void requestDocument(DocumentRequest request) {
    _requests.add(request);
  }

  List<DocumentRequest> getRequests(String studentName) {
    return _requests.where((request) => request.studentName == studentName).toList();
  }

  void makePayment(Payment payment) {
    _payments.add(payment);
    DocumentRequest? request = _requests.firstWhere(
      (req) => req.id == payment.requestId,
      orElse: () => DocumentRequest(id: '', studentName: '', documentType: '', amount: 0),
    );
    if (request != null) {
      request.status = "Completed";
    }
  }

  bool checkPaymentStatus(String requestId) {
    return _payments.any((payment) => payment.requestId == requestId && payment.isPaid);
  }

  List<DocumentRequest> getAllRequests() {
    return _requests;
  }
}

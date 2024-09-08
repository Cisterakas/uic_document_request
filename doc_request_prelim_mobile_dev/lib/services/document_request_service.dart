import '../models/document_request.dart';

class DocumentRequestService {
  final List<DocumentRequest> _requests = [];

  void requestDocument({
    required String id,
    required String studentName,
    required String documentType,
  }) {
    _requests.add(DocumentRequest(
      id: id,
      studentName: studentName,
      documentType: documentType,
    ));
    print('Document request submitted successfully!');
  }

  List<DocumentRequest> getRequests() {
    return _requests;
  }
}
import 'dart:io';
import '../models/document.dart';
import '../models/document_request.dart';
import 'document_service.dart';

class DocumentRequestService {
  final List<DocumentRequest> _requests = [];
  final DocumentService _documentService;

  DocumentRequestService(this._documentService);

  void requestDocument() {
    List<Document> documents = _documentService.getDocuments();

    // Check if there are any documents available
    if (documents.isEmpty) {
      print('No documents available to request. Please add documents first.');
      return; // Exit the function if there are no documents
    }

    // Display the list of available documents
    print('\nAvailable Documents:');
    for (var document in documents) {
      print(
          'ID: ${document.id}, Name: ${document.name}, Price: \Php.${document.price.toStringAsFixed(2)}');
    }

    // Prompt for user name
    stdout.write('Enter the name: ');
    String? studentName = stdin.readLineSync();

    // Check if student name is null or empty
    if (studentName == null || studentName.isEmpty) {
      print('Error: Student name cannot be null or empty.');
      return; // Exit the function if the name is invalid
    }

    // Prompt for document ID to request
    stdout.write('Enter document ID to request: ');
    String? inputDocumentId = stdin.readLineSync();

    // Check if document ID is null or empty
    if (inputDocumentId == null || inputDocumentId.isEmpty) {
      print('Error: Document ID cannot be null or empty.');
      return; // Exit the function if the document ID is invalid
    }

    if (_documentService.isDocumentAvailable(inputDocumentId)) {
      // Proceed to add the document request
      _requests.add(
        DocumentRequest(
          id: inputDocumentId,
          studentName: studentName, // Student name is already validated
          documentType: _documentService.getDocumentById(inputDocumentId)!.name,
        ),
      );
      print('Document request submitted successfully!');
    } else {
      print(
          'Error: Invalid document ID or document not found. Please try again.');
    }
  }

  List<DocumentRequest> getRequests() {
    return _requests;
  }

  void listRequests() {
    List<DocumentRequest> requests = getRequests();
    if (requests.isEmpty) {
      print('No document requests found.');
    } else {
      print('List of Document Requests:');
      for (var request in requests) {
        print(
            'ID: ${request.id}, Student: ${request.studentName}, Document: ${request.documentType}');
      }
    }
  }
}

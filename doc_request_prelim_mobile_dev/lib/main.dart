import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'providers/global_providers.dart';
import 'services/document_service.dart';
import 'services/document_request_service.dart';
import 'models/document_request.dart';
import 'models/document.dart';

void main() {
  final container = ProviderContainer();
  final documentService = container.read(documentServiceProvider);
  final documentRequestService = container.read(documentRequestServiceProvider);

  while (true) {
    print('\nDocument Request System');
    print('1. Add Document');
    print('2. Request Document');
    print('3. List Requests');
    print('4. Exit');
    stdout.write('Choose an option: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        _addDocument(documentService);
        break;
      case '2':
        _requestDocument(documentService, documentRequestService);
        break;
      case '3':
        _listRequests(documentRequestService);
        break;
      case '4':
        exit(0);
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

void _addDocument(DocumentService documentService) {
  stdout.write('Enter document ID: ');
  String? id = stdin.readLineSync();
  stdout.write('Enter document name: ');
  String? name = stdin.readLineSync();

  double? price;
  while (true) {
    stdout.write('Enter document price: ');
    String? priceInput = stdin.readLineSync();
    
    // Try to parse the input to a double
    if (priceInput != null && double.tryParse(priceInput) != null) {
      price = double.parse(priceInput);
      break; // Exit the loop if the price is valid
    } else {
      print('Invalid input. Please enter a valid number for the price.');
    }
  }

  if (id != null && name != null) {
    documentService.addDocument(
      id: id,
      name: name,
      price: price!, // Using null assertion operator (!) to assert that price is not null
    );
  }
}

void _requestDocument(DocumentService documentService, DocumentRequestService documentRequestService) {
  List<Document> documents = documentService.getDocuments();
  
  // Check if there are any documents available
  if (documents.isEmpty) {
    print('No documents available to request. Please add documents first.');
    return;
  }

  // Display the list of available documents
  print('\nAvailable Documents:');
  for (var document in documents) {
    print('ID: ${document.id}, Name: ${document.name}, Price: \Php ${document.price}');
  }
  
  stdout.write('Enter your name: ');
  String? studentName = stdin.readLineSync();
  stdout.write('Enter document ID to request: ');
  String? documentId = stdin.readLineSync();

  if (documentService.isDocumentAvailable(documentId)) {
    documentRequestService.requestDocument(
      id: documentId!,
      studentName: studentName!,
      documentType: documentService.getDocumentById(documentId)!.name,
    );
  } else {
    print('Document not found.');
  }
}

void _listRequests(DocumentRequestService documentRequestService) {
  List<DocumentRequest> requests = documentRequestService.getRequests();
  if (requests.isEmpty) {
    print('No document requests found.');
  } else {
    print('Your Document Requests:');
    for (var request in requests) {
      print('ID: ${request.id}, Student: ${request.studentName}, Document: ${request.documentType}');
    }
  }
}
import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'providers/global_providers.dart'; 
import 'models/document_request.dart';
import 'models/document.dart';
import 'models/customer.dart';
import 'models/payment.dart';


void main() {
  final container = ProviderContainer();
  final documentRequestService = container.read(documentRequestServiceProvider);
  final documentService = container.read(documentServiceProvider);
  final customerService = container.read(customerServiceProvider);

  while (true) {
    print('\nDocument Request System');
    print('1. Request Document');
    print('2. Make Payment');
    print('3. List My Requests');
    print('4. Check Payment Status');
    print('5. Admin View Requests');
    print('6. Add Document');
    print('7. Add Customer');
    print('8. List Documents');
    print('9. Exit');
    stdout.write('Choose an option: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        _requestDocument(documentRequestService, customerService);
        break;
      case '2':
        _makePayment(documentRequestService);
        break;
      case '3':
        _listMyRequests(documentRequestService);
        break;
      case '4':
        _checkPaymentStatus(documentRequestService);
        break;
      case '5':
        _adminViewRequests(documentRequestService);
        break;
      case '6':
        _addDocument(documentService);
        break;
      case '7':
        _addCustomer(customerService);
        break;
      case '8':
        _listDocuments(documentService);
        break;
      case '9':
        exit(0);
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

void _requestDocument(documentRequestService, customerService) {
  // Check if there are available documents
  if (documentRequestService.documentService.getDocuments().isEmpty) {
    print('No documents available to request. Please add documents first.');
    return; // Exit the method if no documents are available
  }

  stdout.write('Enter your name: ');
  String? studentName = stdin.readLineSync();
  stdout.write('Enter document type: ');
  String? documentType = stdin.readLineSync();
  stdout.write('Enter request ID: ');
  String? id = stdin.readLineSync();
  stdout.write('Enter amount to be paid: ');
  double amount = double.tryParse(stdin.readLineSync()!) ?? 0.0;

  if (studentName != null && documentType != null && id != null) {
    documentRequestService.requestDocument(DocumentRequest(
      id: id,
      studentName: studentName,
      documentType: documentType,
      amount: amount,
    ));
    print('Document request submitted successfully!');
  } else {
    print('Document request details cannot be empty.');
  }
}

void _makePayment(documentRequestService) {
  stdout.write('Enter request ID for payment: ');
  String? requestId = stdin.readLineSync();
  stdout.write('Enter payment amount: ');
  double amount = double.tryParse(stdin.readLineSync()!) ?? 0.0;

  if (requestId != null) {
    documentRequestService.makePayment(Payment(
      requestId: requestId,
      amount: amount,
      isPaid: true,
    ));
    print('Payment made successfully!');
  }
}

void _listMyRequests(documentRequestService) {
  stdout.write('Enter your name: ');
  String? studentName = stdin.readLineSync();
  if (studentName != null) {
    List<DocumentRequest> requests = documentRequestService.getRequests(studentName);
    if (requests.isEmpty) {
      print('No requests found for $studentName.');
    } else {
      print('Your Document Requests:');
      for (var request in requests) {
        print('ID: ${request.id}, Type: ${request.documentType}, Status: ${request.status}, Amount: \$${request.amount}');
      }
    }
  }
}

void _checkPaymentStatus( documentRequestService) {
  stdout.write('Enter request ID to check payment status: ');
  String? requestId = stdin.readLineSync();
  if (requestId != null) {
    bool isPaid = documentRequestService.checkPaymentStatus(requestId);
    print(isPaid ? 'Payment is completed for request ID: $requestId.' : 'Payment is not completed for request ID: $requestId.');
  }
}

void _adminViewRequests( documentRequestService) {
  List<DocumentRequest> allRequests = documentRequestService.getAllRequests();
  if (allRequests.isEmpty) {
    print('No document requests found.');
  } else {
    print('All Document Requests:');
    for (var request in allRequests) {
      print('ID: ${request.id}, Student: ${request.studentName}, Type: ${request.documentType}, Status: ${request.status}, Amount: \$${request.amount}');
    }
  }
}

void _addDocument( documentService) {
  stdout.write('Enter document ID: ');
  String? id = stdin.readLineSync();
  stdout.write('Enter document name: ');
  String? name = stdin.readLineSync();
  stdout.write('Enter document price: ');
  double price = double.tryParse(stdin.readLineSync()!) ?? 0.0;

  if (id != null && name != null) {
    documentService.addDocument(Document(
      id: id,
      name: name,
      price: price,
    ));
    print('Document added successfully!');
  }
}

void _addCustomer(customerService) {
  stdout.write('Enter customer ID: ');
  String? id = stdin.readLineSync();
  stdout.write('Enter customer name: ');
  String? name = stdin.readLineSync();

  if (id != null && name != null) {
    customerService.addCustomer(Customer(
      id: id,
      name: name,
    ));
    print('Customer added successfully!');
  }
}

void _listDocuments(documentService) {
  List<Document> documents = documentService.getDocuments();
  if (documents.isEmpty) {
    print('No documents available.');
  } else {
    print('Available Documents:');
    for (var document in documents) {
      print('ID: ${document.id}, Name: ${document.name}, Price: \$${document.price}');
    }
  }
}
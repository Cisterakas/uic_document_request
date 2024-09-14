import 'dart:io';
import '../models/document.dart';

class DocumentService {
  final List<Document> _documents = [];

  void addDocument({
    required String id,
    required String name,
    required double price,
  }) {
    // Check for duplicate document ID
    if (_documents.any((doc) => doc.id == id)) {
      print('Error: A document with ID "$id" already exists. Please use a unique ID.');
      return; // Exit the method if the document ID is not unique
    }

    // Add the document if the ID is unique
    _documents.add(Document(
      id: id,
      name: name,
      price: price,
    ));
    print('Document added successfully!');
  }

  void deleteDocument(String id) {
    // Check if there are any documents available
    if (_documents.isEmpty) {
      print('Error: No documents available to delete.');
      return; // Exit the function if there are no documents
    }

    // Display the list of available documents
    print('\nAvailable Documents:');
    for (var document in _documents) {
      print('ID: ${document.id}, Name: ${document.name}, Price: \$${document.price}');
    }

    // Prompt for document ID to delete
    stdout.write('Enter document ID to delete: ');
    String? inputId = stdin.readLineSync();

    if (inputId != null) {
      if (isDocumentAvailable(inputId)) {
        _documents.removeWhere((doc) => doc.id == inputId);
        print('Document with ID "$inputId" has been deleted successfully!');
      } else {
        print('Error: Document with ID "$inputId" not found.');
      }
    }
  }

  List<Document> getDocuments() {
    return _documents;
  }

  bool isDocumentAvailable(String? documentId) {
    return _documents.any((doc) => doc.id == documentId);
  }

  Document? getDocumentById(String? documentId) {
    return _documents.firstWhere(
      (doc) => doc.id == documentId,
      orElse: () => Document(id: '', name: '', price: 0), // Return an empty Document object if the document is not found
    );
  }

  void manageDocument() {
    while (true) {
      print('\nManage Document');
      print('1. Add Document');
      print('2. Delete Document');
      print('3. Back to Main Menu');
      stdout.write('Choose an option: ');

      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          _addDocument();
          break;
        case '2':
          deleteDocument(''); // Call deleteDocument with an empty string
          break; // The deleteDocument method will handle the logic
        case '3':
          return; // Go back to the main menu
        default:
          print('Invalid choice. Please try again.');
      }
    }
  }

  void _addDocument() {
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
      addDocument(
        id: id,
        name: name,
        price: price!, // Using null assertion operator (!) to assert that price is not null
      );
    }
  }
}
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

  List<Document> getDocuments() {
    return _documents;
  }

  bool isDocumentAvailable(String? documentId) {
    return _documents.any((doc) => doc.id == documentId);
  }

  Document getDocumentById(String? documentId) {
    return _documents.firstWhere(
      (doc) => doc.id == documentId,
      orElse: () => Document(id: '', name: '', price: 0), // Return a default Document object
    );
  }
}
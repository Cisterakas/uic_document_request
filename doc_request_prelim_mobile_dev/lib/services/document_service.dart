import '../models/document.dart';

class DocumentService {
  final List<Document> _documents = [
    Document(id: '1', name: 'Transcript', price: 10.0),
    Document(id: '2', name: 'Certificate', price: 15.0),
    Document(id: '3', name: 'ID Card', price: 5.0),
  ];

  void addDocument(Document document) {
    _documents.add(document);
  }

  List<Document> getDocuments() {
    return _documents;
  }
}
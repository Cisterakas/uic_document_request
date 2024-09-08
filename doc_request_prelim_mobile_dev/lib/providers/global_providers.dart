import 'package:riverpod/riverpod.dart';
import '../services/document_service.dart';
import '../services/document_request_service.dart';

// Document Service Provider
final documentServiceProvider = Provider<DocumentService>((ref) {
  return DocumentService();
});

// Document Request Service Provider
final documentRequestServiceProvider = Provider<DocumentRequestService>((ref) {
  return DocumentRequestService();
});
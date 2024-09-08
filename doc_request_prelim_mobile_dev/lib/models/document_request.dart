class DocumentRequest {
  final String id; // Unique identifier for the request
  final String studentName; // Name of the student making the request
  final String documentType; // Type of document requested

  DocumentRequest({
    required this.id,
    required this.studentName,
    required this.documentType,
  });
}
class DocumentRequest {
  final String id; // Unique identifier for the request
  final String studentName; // Name of the student making the request
  final String documentType; // Type of document requested
  String status; // Status of the request (e.g., "Pending", "Completed")
  double amount; // Amount to be paid for the request

  DocumentRequest({
    required this.id,
    required this.studentName,
    required this.documentType,
    this.status = "Pending", // Default status
    required this.amount,
  });
}
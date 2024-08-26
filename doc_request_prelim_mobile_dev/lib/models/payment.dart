class Payment {
  final String requestId; // The ID of the document request
  final double amount; // Amount paid
  bool isPaid; // Indicates if the payment is completed

  Payment({
    required this.requestId,
    required this.amount,
    this.isPaid = false, // Default to not paid
  });
}
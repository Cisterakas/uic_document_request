import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'providers/global_providers.dart';

void main() {
  final container = ProviderContainer();
  final documentService = container.read(documentServiceProvider);
  final documentRequestService = container.read(documentRequestServiceProvider);

  while (true) {
    print('\nDocument Request System');
    print('1. Manage Document');
    print('2. Request Document');
    print('3. List Requests');
    print('4. Exit');
    stdout.write('Choose an option: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        documentService.manageDocument();
        break;
      case '2':
        documentRequestService.requestDocument(); // No need to pass studentName here
        break;
      case '3':
        documentRequestService.listRequests();
        break;
      case '4':
        print('Exiting the application...');
        return;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}
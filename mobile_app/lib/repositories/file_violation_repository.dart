import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> addViolations(List<String> plateNumbers) async {
  final apiUrl = 'http://10.0.2.2:3000/add_violation';

  for (final plateNumber in plateNumbers) {
    final violationRecord = {
      'user_id': plateNumber,
      'time': DateTime.now().toIso8601String(),
      'violation_type': 'violation type',
      'evidence_image': 'evidence.jpg',
      'black_points': 2,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(violationRecord),
    );

    if (response.statusCode == 200) {
      print('Violation added for plate number: $plateNumber');
    } else {
      print('Failed to add violation for plate number: $plateNumber');
    }
  }
}

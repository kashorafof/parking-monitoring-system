import 'dart:convert';
import 'package:http/http.dart' as http;

Future<double> manipulateNumbers(double a, double b) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:5000/manipulate_numbers'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'a': a, 'b': b}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['result'];
  } else {
    throw Exception('Failed to manipulate numbers.');
  }
}
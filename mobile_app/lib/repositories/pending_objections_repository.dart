import 'package:http/http.dart' as http;

Future<void> changeObjectionStatus(String objectionID, bool newStatus) async {
  final url = Uri.parse('http://10.0.2.2:3000/change_objection_status/$objectionID/$newStatus');
  print('dsad');
  final response = await http.put(url);

  if (response.statusCode == 200) {
    // Objection status changed successfully
    print('Objection status changed for objection ID: $objectionID');
  } else {
    // Error occurred while changing objection status
    print('Failed to change objection status: ${response.statusCode}');
  }
}

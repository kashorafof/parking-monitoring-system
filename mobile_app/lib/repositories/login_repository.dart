import 'package:mobile_app/models/Account.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


String tempName = 'testName';
Image tempImage = Image.asset('assets/user_image.jpg');

Future<Account> verifyLogin(String id, String password) async {
  final url = Uri.parse('http://10.0.2.2:3000/verify_login');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'ID': id, 'password': password});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    print(jsonData['Is_adminstration'] );
    return Account(
      //name: jsonData['name'],
      name: tempName, // TODO: Change this to jsonData['name'] when the API is ready
      ID: jsonData['ID'],
      totalFines: jsonData['Total_fines'],
      totalBlackPoints: jsonData['black_points'],
      //profileImage: jsonData['profileImage'],
      profileImage: tempImage, //TODO: Change this to Image.network(jsonData['profileImage']) when the API is ready
      isAdmin: jsonData['Is_adminstration'],
    );
  } else if (response.statusCode == 401) {
    throw Exception('Invalid login credentials');
  } else {
    throw Exception('Failed to verify login: ${response.statusCode}');
  }
}

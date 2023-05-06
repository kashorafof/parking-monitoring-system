import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<ViolationRecord>> getRecords(String id) async {
  final url = Uri.parse('http://10.0.2.2:3000/get_records/$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final records = List<Map<String, dynamic>>.from(jsonData);
    return records.map((record) => ViolationRecord(
      //violationID: record['_id'],
      violationID: 'V2541',
      violationType: record['violation_type'],
      violationBlackPoints: record['black_points'],
      //violationFine: record['violationFine'],
      violationFine: record['black_points']*3,
      violationTime: record['time'],
      //violationImage: record['evidence_image'],
      violationImage: Image.asset('assets/violation_image.jpg'),
    )).toList();
  } else {
    throw Exception('Failed to get records: ${response.statusCode}');
  }
}




Future<List<Objection>> getObjections() async {
  final url = Uri.parse('http://10.0.2.2:3000/get_objections');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final objections = List<Map<String, dynamic>>.from(jsonData);
    return objections.map((objection) => Objection(
      violationID: objection['violation_id'],
      objectionID: objection['_id'],
      //objecitonTime: objection['objectionTime'],.
      objecitonTime : '2023-05-03 10:00 AM',
      currentStatus: objection['status'] == true ? objectionStatus.accepted : objectionStatus.pending,
      userID: objection['user_id'],
      objectionDescription: objection['reason'],
    )).toList();
  } else {
    throw Exception('Failed to get objections: ${response.statusCode}');
  }
}

Future<List<Objection>> getObjectionsID(String id) async {
  
  List<Objection> objections = await getObjections();

  List<Objection> result = [];
  for (var i = 0; i < objections.length; i++) {
    print(objections[i].objectionDescription);
    if (objections[i].userID == id) {
      result.add(objections[i]);
    }
  }
  return result;
  
}


Future<List<Objection>> getPendingObjections() async{

  List<Objection> objections = await getObjections();

  List<Objection> result = [];
  for (var i = 0; i < objections.length; i++) {
    if (objections[i].currentStatus == objectionStatus.pending) {
      result.add(objections[i]);
    }
  }
  return result;

}
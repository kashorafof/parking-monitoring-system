import 'package:flutter/material.dart';

final scriptPath = 'lib/models/script.py';

class AppColors {
  static const Color primaryColor = Color(0xFF52B6FF);
  static const Color accentColor = Color(0xFFFF4081);
  //static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF000000);
  static const Color buttonsColor = Color.fromARGB(255, 52, 114, 247);
  static const Color backgroundColor = Colors.black;
}

class ViolationRecord {
  String violationID;
  String violationType;
  int violationFine;
  int violationBlackPoints;
  String violationTime;
  Image violationImage;

  ViolationRecord({
    required this.violationID,
    required this.violationType,
    required this.violationFine,
    required this.violationBlackPoints,
    required this.violationTime,
    required this.violationImage,
  });
}


enum objectionStatus {
  pending,
  accepted,
  rejected,
}


class Objection{
  String violationID;
  String objectionID;
  String objecitonTime;
  objectionStatus currentStatus;
  String objectionDescription;


  Objection({
    required this.violationID,
    required this.objectionID,
    required this.objecitonTime,
    required this.currentStatus,
    required this.objectionDescription,
  });
}

List<ViolationRecord> violationList = [
  ViolationRecord(
    violationID: 'V123',
    violationType : 'crosswalk parking',
    violationFine: 50,
    violationBlackPoints: 3,
    violationTime: '2023-05-03 10:00 AM',
    violationImage: Image.asset('assets/violation_image.jpg'),
  ),
  ViolationRecord(
    violationID: 'V456',
    violationType : 'overlapping parking',
    violationFine: 100,
    violationBlackPoints: 5,
    violationTime: '2023-05-04 02:30 PM',
    violationImage: Image.asset('assets/violation_image2.jpg'),
  ),
  ViolationRecord(
    violationID: 'V789',
    violationType : 'car accedent',
    violationFine: 75,
    violationBlackPoints: 4,
    violationTime: '2023-05-05 09:15 AM',
    violationImage: Image.asset('assets/violation_image3.jpg'),
  ),
  ViolationRecord(
    violationID: 'V123',
    violationType : 'crosswalk parking',
    violationFine: 50,
    violationBlackPoints: 3,
    violationTime: '2023-05-03 10:00 AM',
    violationImage: Image.asset('assets/violation_image.jpg'),
  ),
  ViolationRecord(
    violationID: 'V456',
    violationType : 'overlapping parking',
    violationFine: 100,
    violationBlackPoints: 5,
    violationTime: '2023-05-04 02:30 PM',
    violationImage: Image.asset('assets/violation_image2.jpg'),
  ),
  ViolationRecord(
    violationID: 'V789',
    violationType : 'car accedent',
    violationFine: 75,
    violationBlackPoints: 4,
    violationTime: '2023-05-05 09:15 AM',
    violationImage: Image.asset('assets/violation_image3.jpg'),
  ),
  ViolationRecord(
    violationID: 'V123',
    violationType : 'crosswalk parking',
    violationFine: 50,
    violationBlackPoints: 3,
    violationTime: '2023-05-03 10:00 AM',
    violationImage: Image.asset('assets/violation_image.jpg'),
  ),
  ViolationRecord(
    violationID: 'V456',
    violationType : 'overlapping parking',
    violationFine: 100,
    violationBlackPoints: 5,
    violationTime: '2023-05-04 02:30 PM',
    violationImage: Image.asset('assets/violation_image2.jpg'),
  ),
  ViolationRecord(
    violationID: 'V789',
    violationType : 'car accedent',
    violationFine: 75,
    violationBlackPoints: 4,
    violationTime: '2023-05-05 09:15 AM',
    violationImage: Image.asset('assets/violation_image3.jpg'),
  ),
];

List<Objection> objectionsList = [

  Objection(
    violationID: "V1",
    objectionID: "O1",
    objecitonTime: "2023-05-03 10:00 AM",
    currentStatus: objectionStatus.pending,
    objectionDescription: "Description 1",
  ),
  Objection(
    violationID: "V456",
    objectionID: "O002",
    objecitonTime: "2023-05-03 11:30 AM",
    currentStatus: objectionStatus.accepted,
    objectionDescription: "This is the second objection.",
  ),
  Objection(
    violationID: "V789",
    objectionID: "O003",
    objecitonTime: "2023-05-03 2:15 PM",
    currentStatus: objectionStatus.rejected,
    objectionDescription: "This is the third objection.",
  ),
  Objection(
    violationID: "V123",
    objectionID: "O004",
    objecitonTime: "2023-05-03 3:45 PM",
    currentStatus: objectionStatus.pending,
    objectionDescription: "This is the fourth objection.",
  ),
  Objection(
    violationID: "V456",
    objectionID: "O005",
    objecitonTime: "2023-05-03 4:30 PM",
    currentStatus: objectionStatus.accepted,
    objectionDescription: "This is the fifth objection.",
  ),
];


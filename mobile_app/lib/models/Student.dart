import 'package:flutter/material.dart';

class Student{

  String name;
  String ID;
  int totalFines;
  int totalBlackPoints;
  Image profileImage;

  Student({
    required this.name,
    required this.ID,
    required this.totalFines,
    required this.totalBlackPoints,
    required this.profileImage,
  });
}
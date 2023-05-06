import 'package:flutter/material.dart';

class Account{

  String name;
  String ID;
  int totalFines;
  int totalBlackPoints;
  Image profileImage;
  bool isAdmin;

  Account({
    required this.name,
    required this.ID,
    required this.totalFines,
    required this.totalBlackPoints,
    required this.profileImage,
    required this.isAdmin,
  });
}
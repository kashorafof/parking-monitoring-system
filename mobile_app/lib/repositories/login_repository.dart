import 'package:mobile_app/models/Student.dart';
import 'package:flutter/material.dart';

int verify_login_credintials(String ID, String password) {
  print(ID + " " + password);

  return 1;
}

Student getStudent(String ID) {
  return Student(
    name: "Ahmed",
    ID: "123456789",
    totalFines: 0,
    totalBlackPoints: 0,
    profileImage: Image.asset('assets/images/profile.png'),
  );
}
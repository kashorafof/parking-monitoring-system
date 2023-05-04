import 'package:flutter/material.dart';
import 'package:mobile_app/models/Student.dart';
import 'package:mobile_app/views/student_main_view.dart';
import 'package:mobile_app/repositories/login_repository.dart';


void loginButtonPressed(BuildContext context, TextEditingController emailController, TextEditingController passwordController) {
  String email = emailController.text;
  String password = passwordController.text;
  
  // Perform login logic here, e.g., validate credentials
  // and navigate to the next screen if successful.
  print('Email: $email');
  print('Password: $password');

  // Show an error message if email or password is empty.
  if (email.isEmpty || password.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Email or password cannot be empty.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  // Show an error message if the email is invalid.

  int verificationResult = verify_login_credintials(email, password);

  if (verificationResult == 0) {
    // Invalid email
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Invalid email.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else if (verificationResult == 1) {
    Student _student = getStudent(email);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentPage(student: _student),
      ),
    );
  } else if (verificationResult == 2) {
    // Admin account
    // TODO: Implement admin screen navigation
  }
}
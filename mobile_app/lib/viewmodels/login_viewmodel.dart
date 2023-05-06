import 'package:flutter/material.dart';
import 'package:mobile_app/models/Account.dart';
import 'package:mobile_app/views/student_main_view.dart';
import 'package:mobile_app/repositories/login_repository.dart';
import 'package:mobile_app/views/admin_main_view.dart';


void showError(BuildContext context, String message) {

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
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



Future<void> loginButtonPressed(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async{
  String email = emailController.text;
  String password = passwordController.text;
  
  // Perform login logic here, e.g., validate credentials
  // and navigate to the next screen if successful.
  print('Email: $email');
  print('Password: $password');

  // Show an error message if email or password is empty.
  if (email.isEmpty || password.isEmpty) {
    showError(context, 'Email or password cannot be empty.');
  }


  try{
  final _Account = await verifyLogin(email, password);
    if(_Account.isAdmin){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminPage(Admin: _Account),
        ),
      );
    }
    else{
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentPage(student: _Account),
        ),
      );
    }
  }
  catch(e){
    print(e);
    if(e is Exception){
      if (e.toString().contains('Invalid login credentials')) {
        // Handle the 401 error here
        showError(context, 'Invalid email or password.');
      }
    }
    else{
      showError(context, 'Unknown error occurred');
    }
  }

  return;
}
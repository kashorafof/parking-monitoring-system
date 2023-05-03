import 'package:flutter/material.dart';
import 'package:mobile_app/Student_main_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}




class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () {
                loginButtonPressed(context, _emailController, _passwordController);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}




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
  }

  // if the email start with "stu" -> student account
  if (email.startsWith("stu")) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentPage()),
    );
  }
  // else if the email start with "adm" -> admin account
  

  //! API call to validate credentials
  // if it is an admin account -> open admin page
  // else if it is a student account -> open student page
  // else -> show error message
}
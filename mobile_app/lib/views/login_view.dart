import 'package:flutter/material.dart';
import 'package:mobile_app/views/student_main_view.dart';
import 'package:mobile_app/models/constants.dart';
import 'package:mobile_app/viewmodels/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  double buttonHeight = 60.0; // The default button height

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png',
                width: 180.0,
                height: 180.0,
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    //filled: true,
                    //labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    //filled: true,
                    //labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            loginButtonPressed(context, _emailController, _passwordController);
                          },
                          // set the color of the button to black
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.buttonsColor,
                          ),
                          child: Text('Log in', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




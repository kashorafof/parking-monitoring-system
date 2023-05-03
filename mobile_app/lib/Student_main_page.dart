import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: StudentPage(),
  ));
}

String name = 'طالب كحيان';
String ID = 'U20105102';
int Total_fines = 50, Total_Black_Points = 10;
Image profile_image = Image.asset('assets/user_image.jpg');


class StudentPage extends StatelessWidget {
  double buttonFontSize = 20.0; // The default button font size
  double buttonHeight = 120.0; // The default button height

  @override
  Widget build(BuildContext context) {
    Total_fines = 15;
    
    Future.delayed(const Duration(seconds: 10), () {
      Total_fines = 50;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Page'),
        // remove the return arrow 
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage(profile_image),
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 25.0), // Adjust the padding as desired
                    child: Text(
                      ID,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text('Total Black Points: $Total_Black_Points', style: TextStyle(fontSize: 18.0)),
                  Text('Total Fines: $Total_fines AED', style: TextStyle(fontSize: 18.0)),
                ],
              ),
            ],
          ),
          SizedBox(height: 50.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  // add a button
                  Expanded(
                    child: Container(
                      height: buttonHeight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0), // Adjust the padding as desired
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StudentPage()),
                            );
                          },
                          child: Text('View violations', style: TextStyle(fontSize: buttonFontSize)),
                        ),
                      ),
                    ),
                  ),
                  // add a button
                  Expanded(
                    child: Container(
                      height: buttonHeight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0), // Adjust the padding as desired
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StudentPage()),
                            );
                          },
                          child: Text('View objections', style: TextStyle(fontSize: buttonFontSize)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // add a button
                  Expanded(
                    child: Container(
                      height: buttonHeight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0), // Adjust the padding as desired
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StudentPage()),
                            );
                          },
                          child: Text('View vehicles', style: TextStyle(fontSize: buttonFontSize)),
                        ),
                      ),
                    ),
                  ),
                  // add a button
                  Expanded(
                    child: Container(
                      height: buttonHeight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0), // Adjust the padding as desired
                        child: ElevatedButton(
                          onPressed:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StudentPage()),
                            );
                          },
                          child: Text('Payment', style: TextStyle(fontSize: buttonFontSize)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}




/*
class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 150, // Adjust the width as desired
      child: ListView(
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: 100), // Adjust the height as desired
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
*/
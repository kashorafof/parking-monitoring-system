import 'package:flutter/material.dart';
import 'package:mobile_app/views/objections_view.dart';
import 'package:mobile_app/models/constants.dart';
import 'package:mobile_app/models/Account.dart';
import 'package:mobile_app/views/violation_records_view.dart';
import 'package:mobile_app/views/file_violation_view.dart';
import 'package:mobile_app/viewmodels/main_page_viewmodel.dart';



String name = 'الطالب الكحيان';
String ID = 'U20105102';
int Total_fines = 50, Total_Black_Points = 10;
Image profile_image = Image.asset('assets/user_image.jpg');

class StudentPage extends StatelessWidget {
  final Account student;
  StudentPage({required this.student});
   
  double buttonFontSize = 20.0; // The default button font size
  double buttonHeight = 90.0; // The default button height

  @override
  Widget build(BuildContext context) {
    name = student.name;
    ID = student.ID;
    Total_fines = student.totalFines;
    Total_Black_Points = student.totalBlackPoints;



    return Scaffold(
      appBar: AppBar(
        title: Text('Account Page'),
        // remove the return arrow 
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
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
                backgroundImage: profile_image.image,
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
          
          SizedBox(height: 20.0),
          Expanded(
            child: ListView(
                physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                children: [
                  Container(
                    height: buttonHeight,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonsColor,
                      ),
                      onPressed: () { openViolationRecords(context, ID, true);},
                      child: Text('Violation Records', style: TextStyle(fontSize: buttonFontSize)),
                    ),
                  ),
                  
                  Container(
                    height: buttonHeight,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonsColor,
                      ),
                      onPressed: () {openObjectionStatus(context, ID);},
                      child: Text('Objections status', style: TextStyle(fontSize: buttonFontSize)),
                    ),
                  ),
                  Container(
                    height: buttonHeight,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonsColor,
                      ),
                      onPressed: () {
                        /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ImageUploadPage()),
                        );
                        */
                      },
                      child: Text('Registered vehicle', style: TextStyle(fontSize: buttonFontSize)),
                    ),
                  ),
                  Container(
                    height: buttonHeight,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonsColor,
                      ),
                      onPressed: () { 
                        // 
                      },
                      child: Text('Payment', style: TextStyle(fontSize: buttonFontSize)),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}



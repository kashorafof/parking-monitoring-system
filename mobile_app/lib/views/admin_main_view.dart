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

class AdminPage extends StatelessWidget {
  final Account Admin;
  AdminPage({required this.Admin});

  double buttonFontSize = 20.0; // The default button font size
  double buttonHeight = 90.0; // The default button height
  TextEditingController _student_id_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    name = Admin.name;
    ID = Admin.ID;
    Total_fines = Admin.totalFines;
    Total_Black_Points = Admin.totalBlackPoints;

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
                    padding: EdgeInsets.only(
                        bottom: 25.0), // Adjust the padding as desired
                    child: Text(
                      ID,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text('Total Black Points: $Total_Black_Points',
                      style: TextStyle(fontSize: 18.0)),
                  Text('Total Fines: $Total_fines AED',
                      style: TextStyle(fontSize: 18.0)),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              children: [
                Container(
                  height: buttonHeight,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.buttonsColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: TextField(
                                
                                controller: _student_id_controller,
                                
                                style: TextStyle(fontSize: 18.0, color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: 'View Violation for a student..',
                                  //change the hint color
                                  hintStyle: TextStyle(color: Colors.grey),
                                  filled: true,
                                  
                                  fillColor: Colors.white,

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide.none,
                                  )


                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(  
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color.fromARGB(255, 62, 79, 238),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  // Perform search functionality
                                  openViolationRecords(context, _student_id_controller.text, true);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: buttonHeight,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonsColor,
                    ),
                    onPressed: () {openPendingObjections(context);},
                    child: Text('View Objections',
                        style: TextStyle(fontSize: buttonFontSize)),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageUploadPage()),
                      );
                    },
                    child: Text('File a violation',
                        style: TextStyle(fontSize: buttonFontSize)),
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

import 'package:mobile_app/views/object_violation_view.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/constants.dart';

class ViolationRecordsPage extends StatelessWidget {
  final List<ViolationRecord> violationRecords;
  final bool able_to_object;

  ViolationRecordsPage({required this.violationRecords, required this.able_to_object});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Violation Records'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'List of Violation Records:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              //physics: NeverScrollableScrollPhysics(), 
              
              physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              itemCount: violationRecords.length,
              itemBuilder: (context, index) {
                ViolationRecord record = violationRecords[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: able_to_object ? DismissDirection.endToStart : DismissDirection.none,
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ObjectionPage(record: record),
                          ),
                        );
                      }
                      return false; // Prevent automatic dismissal
                    },
                    background: Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Open Objection', style: TextStyle(color: Colors.white)),
                            Icon(Icons.open_in_new, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: GestureDetector(
                        onTap: () {
                          _showImageDialog(context, record.violationImage.image);
                        },
                        child: CircleAvatar(
                          backgroundImage: record.violationImage.image,
                        ),
                      ),
                      title: Text('${record.violationType}', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Fine: ${record.violationFine} \nBlack Points: ${record.violationBlackPoints}'),
                      trailing: Text('Time: ${record.violationTime}\n Violation ID: ${record.violationID}', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context, ImageProvider imageProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image(image: imageProvider),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_app/models/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mobile_app/viewmodels/object_violation_viewmodel.dart';
class ObjectionPage extends StatefulWidget {
  final ViolationRecord record;

  ObjectionPage({required this.record});

  @override
  _ObjectionPageState createState() => _ObjectionPageState();
}






class _ObjectionPageState extends State<ObjectionPage> {
  File? _imageFile;
  TextEditingController _objectionReasonController = TextEditingController();

  Future<File?> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      return File(pickedImage.path);
    }

    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objection Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Violation ID: ${widget.record.violationID}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text('Fine: ${widget.record.violationFine}'),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'Black Points: ${widget.record.violationBlackPoints}'),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text('Time: ${widget.record.violationTime}'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 160.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: widget.record.violationImage
                                .image, // Replace with your placeholder image asset
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    'Objection Reason:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextField(
                    controller: _objectionReasonController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(94, 238, 238, 238),
                      hintText: 'Enter your objection reason',
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    'Evidence Documents:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(185, 214, 214, 214),
                          ),
                          icon: Icon(Icons.attach_file),
                          label: Text('Upload Document'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 45.0),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 75.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.buttonsColor,
                            ),
                            onPressed: () {
                              submitObjection(context, widget.record ,_objectionReasonController, _imageFile);
                            },
                            child: Text('Submit Objection', style: TextStyle(fontSize: 15.0)),
                          ),
                        ),
                      )
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

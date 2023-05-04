import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mobile_app/repositories/object_violation_repository.dart';
import 'package:mobile_app/models/constants.dart';



void submitObjection(BuildContext context, ViolationRecord record, TextEditingController objectionReasonController, File? _imageFile){
  print("Objection submitted: " + objectionReasonController.text + " " + _imageFile.toString());


  String reason = objectionReasonController.text;
  if (reason.isEmpty){
    // Show an error message if the reason is empty.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Objection reason should not be empty.'),
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

  //! TODO: Submit objection to the database
  sendObjectionToDB(record, objectionReasonController, _imageFile);


  Navigator.pop(context);
  // show a dialog box to inform the user that the objection has been submitted
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Objection Submitted"),
        content: Text("Your objection has been submitted. You will be notified of the outcome."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

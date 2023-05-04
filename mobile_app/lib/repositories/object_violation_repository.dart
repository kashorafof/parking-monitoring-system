import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/constants.dart';


void sendObjectionToDB(ViolationRecord record, TextEditingController objectionReasonController, File? _imageFile){

  if (_imageFile != null){
    // upload the image to the database
  }
  print("ttttObjection submitted: " + objectionReasonController.text + " " + _imageFile.toString());

}

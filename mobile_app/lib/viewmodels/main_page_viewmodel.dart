import 'package:flutter/material.dart';
import 'package:mobile_app/models/Account.dart';
import 'package:mobile_app/views/student_main_view.dart';
import 'package:mobile_app/repositories/login_repository.dart';
import 'package:mobile_app/views/admin_main_view.dart';
import 'package:mobile_app/repositories/main_page_repository.dart';
import 'package:mobile_app/models/constants.dart';
import 'package:mobile_app/views/violation_records_view.dart';
import 'package:mobile_app/views/objections_view.dart';
import 'package:mobile_app/views/pending_objections_view.dart';

Future<void> openViolationRecords(BuildContext context, String ID, bool student) async{

  List<ViolationRecord> _records = await getRecords(ID);
  print('new');
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ViolationRecordsPage(violationRecords: _records, able_to_object: student, ID: ID)),
  );
}


Future<void> openObjectionStatus(BuildContext context, String ID) async{
  List<Objection> _objections = await getObjectionsID(ID);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ObjectionsStatusPage(objections: _objections)),
  );
}


Future<void> openPendingObjections(BuildContext context) async{
  List<Objection> _objections = await getPendingObjections();
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PendingObjectionsPage(objections: _objections)),
  );

}
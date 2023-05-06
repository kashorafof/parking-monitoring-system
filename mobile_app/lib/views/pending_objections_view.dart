import 'package:flutter/material.dart';
import 'package:mobile_app/models/constants.dart';
import 'package:mobile_app/viewmodels/pending_objections_viewmodel.dart';

class PendingObjectionsPage extends StatefulWidget {
  final List<Objection> objections;

  PendingObjectionsPage({required this.objections});

  @override
  _PendingObjectionsPageState createState() => _PendingObjectionsPageState();
}

class _PendingObjectionsPageState extends State<PendingObjectionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Objections'),
      ),
      body: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: widget.objections.length,
        itemBuilder: (context, index) {
          Objection objection = widget.objections[index];
          return Dismissible(
            key: Key(objection.objectionID),
            onDismissed: (direction) {
              // Perform the removal of the objection from the list here
              setState(() {
                widget.objections.removeAt(index);
                print('objected removed');
                AcceptObjection(objection.objectionID);
              });
              // Show a snackbar or perform any other action after the objection is removed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Objection approved')),
              );
            },
            background: Container(
              color: Colors.green,
              child: Icon(Icons.check, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 16.0),
            ),
            child: ListTile(
              title: Text('Violation ID: ${objection.violationID}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Objector: ${objection.userID}'),
                  SizedBox(height: 4),
                  Text(
                    'Time: ${objection.objecitonTime}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Description: ${objection.objectionDescription}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

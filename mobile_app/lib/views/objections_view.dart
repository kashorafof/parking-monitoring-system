import 'package:flutter/material.dart';
import 'package:mobile_app/models/constants.dart';

class ObjectionsStatusPage extends StatelessWidget {
  final List<Objection> objections;

  ObjectionsStatusPage({required this.objections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objections Status'),
      ),
      body: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: objections.length,
        itemBuilder: (context, index) {
          Objection objection = objections[index];
          return ListTile(
            title: Text('Violation ID: ${objection.violationID}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Objection ID: ${objection.objectionID}'),
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
            trailing: _buildStatusBadge(objection.currentStatus),
          );
        },
      ),
    );
  }

  Widget _buildStatusBadge(objectionStatus status) {
    Color? badgeColor;
    String statusText;

    switch (status) {
      case objectionStatus.pending:
        badgeColor = Colors.yellow;
        statusText = 'Pending';
        break;
      case objectionStatus.accepted:
        badgeColor = Colors.green;
        statusText = 'Accepted';
        break;
      case objectionStatus.rejected:
        badgeColor = Colors.red;
        statusText = 'Rejected';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

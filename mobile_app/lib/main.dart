import 'package:flutter/material.dart';
import 'package:mobile_app/Login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor blackSwatch = MaterialColor(
      0xFF000000,
      <int, Color>{
        50: Color(0xFF000000),
        100: Color(0xFF000000),
        200: Color(0xFF000000),
        300: Color(0xFF000000),
        400: Color(0xFF000000),
        500: Color(0xFF000000),
        600: Color(0xFF000000),
        700: Color(0xFF000000),
        800: Color(0xFF000000),
        900: Color(0xFF000000),
      },
    );

    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        primarySwatch: blackSwatch,
      ),
      home: LoginPage(),
    );
  }
}

// import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
// class StudentPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Page'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             margin: EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => UserPage()),
//                 );
//               },
//               child: Text('User Info'),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Text('Total Black Points: 10'),
//                 Text('Total Fines: \$50'),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ViolationPage()),
//                       );
//                     },
//                     child: Text('Violations'),
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all<Color>(Colors.red),
//                       padding: MaterialStateProperty.all<EdgeInsets>(
//                         EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
//                       ),
//                       textStyle: MaterialStateProperty.all<TextStyle>(
//                         TextStyle(fontSize: 20.0),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Add your code for the payments button here
//                     },
//                     child: Text('Payments'),
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all<Color>(Colors.blue),
//                       padding: MaterialStateProperty.all<EdgeInsets>(
//                         EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
//                       ),
//                       textStyle: MaterialStateProperty.all<TextStyle>(
//                         TextStyle(fontSize: 20.0),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Add your code for the search button here
//               },
//               child: Text('Search'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class UserPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Info'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 80.0,
//               backgroundImage: AssetImage('assets/user_image.jpg'),
//             ),
//             SizedBox(height: 16.0),
//             Text('John Doe'),
//             Text('ID: 123456'),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Add your code for viewing registered vehicles here
//               },
//               child: Text('View Registered Vehicles'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Add your code for account settings here
//               },
//               child: Text('Account Settings'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ViolationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Violation Details'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//             body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 20.0),
//           Text(
//             'Parking lines',
//             style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10.0),
//           Text(
//             'Black points:',
//             style: TextStyle(fontSize: 18.0),
//           ),
//           Text(
//             '5',
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10.0),
//           Text(
//             'Fine:',
//             style: TextStyle(fontSize: 18.0),
//           ),
//           Text(
//             'AED 250',
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20.0),
//           Image.asset(
//             'assets/violation_image.jpg',
//             height: 200.0,
//           ),
//           SizedBox(height: 20.0),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ObjectionPage()),
//               );
//             },
//             child: Text('Apply a Review'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ObjectionPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Objection'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Reason of Objection',
//               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10.0),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Enter your reason...',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               'Upload Documents (optional)',
//               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10.0),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Upload your documents...',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



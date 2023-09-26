import 'package:flutter/material.dart';

class ManagerScreen extends StatelessWidget {
  final Map<String, dynamic>? managerData;
  final String imageUrl;

  ManagerScreen({this.managerData,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (managerData != null)
              Column(
                children: <Widget>[
                  Text('Welcome, ${managerData!['first_name']} ${managerData!['last_name']} (Manager)'),
                  Text('Employee ID: ${managerData!['emp_id']}'),
                  Text('Phone: ${managerData!['phone']}'),
                  Text('Email: ${managerData!['email']}'),
                  Text('Designation: ${managerData!['designation']}'),
                ],
              ),
            if (managerData == null)
              Text('Manager data not available'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  final Map<String, dynamic>? employeeData;
  final String? imageUrl;

  EmployeeScreen({this.employeeData, this.imageUrl});

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Dashboard'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.pink],
            ),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(16.0),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: widget.imageUrl != null
                    ? Image.network(
                  widget.imageUrl!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )
                    : SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Text('No Image'),
                  ),
                ),
              ),
              title: Text(
                'Welcome, ${widget.employeeData!['first_name']} ${widget.employeeData!['last_name']} ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text('Employee ID: ${widget.employeeData!['emp_id']}'),
                  SizedBox(height: 10),
                  Text('Phone: ${widget.employeeData!['phone']}'),
                  SizedBox(height: 10),
                  Text('Email: ${widget.employeeData!['email']}'),
                  SizedBox(height: 10),
                  Text('Designation: ${widget.employeeData!['designation']}'),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                      });

                      print('Selected Date for Leave Request: $selectedDate');
                    }
                  },
                  child: Card(
                    elevation: 4,
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.pink], // Change gradient colors here
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Leave Request',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Attendance card tapped');
                  },
                  child: Card(
                    elevation: 4,
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.pink], // Gradient colors here
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Attendance',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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

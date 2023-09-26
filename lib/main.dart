import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leave/ManagerScreen.dart';
import 'package:leave/EmployeeScreen.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.green,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _empIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _clearError() {
    setState(() {
      _errorMessage = '';
    });
  }

  Future<void> _handleLogin() async {
    _clearError();

    final int empId = int.tryParse(_empIdController.text) ?? 0;
    final String password = _passwordController.text;

    final Uri apiUrl = Uri.parse('http://10.16.48.119:4000/api/login');
    final Map<String, dynamic> requestBody = {
      'emp_id': empId,
      'password': password,
    };

    try {
      final response = await http.post(
        apiUrl,
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'];
        final role = responseData['role'];

        if (message == 'Login success') {
          if (role == 'manager') {
            final imageUrl = '';
            final managerData = responseData;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ManagerScreen(
                  managerData: managerData,
                  imageUrl: imageUrl,
                ),

              ),
            );
          } else if (role == 'employee') {
            final imageUrl = '';
            final employeeData = responseData;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EmployeeScreen(
                  employeeData: employeeData,
                  imageUrl: imageUrl,
                ),
              ),
            );
          }
        } else {
          setState(() {
            _errorMessage = 'Login failed: $message';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid credentials';
        });
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.white,
                Colors.lightBlueAccent,

              ])),
        ),
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.white,
              Colors.lightBlueAccent,
              Colors.blueGrey
            ])),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                height: 100,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _empIdController,
                decoration: InputDecoration(
                  labelText: 'Employee ID',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _handleLogin();
                },
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

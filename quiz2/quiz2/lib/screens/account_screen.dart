import 'package:flutter/material.dart';
import 'package:quiz2/screens/forgot_password_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccountScreen(),
    );
  }
}

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 32,
                    color: Colors.black,
                  ),
                  Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Switch between your existing account and manage your account.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Existing Account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Manage Account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                child: Text('A', style: TextStyle(fontSize: 24)),
              ),
              Text('John Doe', style: TextStyle(fontSize: 16)),
              Text('john@example.com', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Text('B', style: TextStyle(fontSize: 24)),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Text('C', style: TextStyle(fontSize: 24)),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Text('D', style: TextStyle(fontSize: 24)),
                  ),
                ],
              ),
              Text('Jane Doe', style: TextStyle(fontSize: 16)),
              Text('jane@example.com', style: TextStyle(fontSize: 16)),
              Text('Bob Smith', style: TextStyle(fontSize: 16)),
              Text('bob@example.com', style: TextStyle(fontSize: 16)),
              Text('Alice Johnson', style: TextStyle(fontSize: 16)),
              Text('alice@example.com', style: TextStyle(fontSize: 16)),
              ElevatedButton(
                onPressed: () {
                  // Add logic to navigate to the "Forgot Password" screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: Size(200, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Add Another Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

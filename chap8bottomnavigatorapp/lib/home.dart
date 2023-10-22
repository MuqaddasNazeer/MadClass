import 'package:flutter/material.dart';
import 'gratitude.dart';
import 'reminders.dart';
import 'birthdays.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Drawer and ListView'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Sandy Smith'),
              accountEmail: Text('sandy.smith@domainname.com'),
              currentAccountPicture: Icon(
                Icons.face,
                size: 72.0,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home_top_mountain.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              otherAccountsPictures: <Widget>[
                Icon(Icons.bookmark_border),
              ],
            ),
            ListTile(
              title: Text('Birthdays'),
              onTap: () {
                Navigator.of(context).pop(); // Close the Drawer
                _navigateTo(Birthdays());
              },
            ),
            ListTile(
              title: Text('Gratitude'),
              onTap: () {
                Navigator.of(context).pop(); // Close the Drawer
                _navigateTo(Gratitude());
              },
            ),
            ListTile(
              title: Text('Reminders'),
              onTap: () {
                Navigator.of(context).pop(); // Close the Drawer
                _navigateTo(Reminders());
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Selected Page'),
            ),
            body: page,
          );
        },
      ),
    );
  }
}

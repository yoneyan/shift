import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift/login.dart';
import 'package:shift/pages/setting.dart';
import 'package:shift/pages/shift.dart';
import 'package:shift/pages/shiftRegistration.dart';

import 'package:shift/services/auth.dart';

class AppDrawer extends StatefulWidget {
//  const AppDrawer({Key key, this.auth}) : super(key: key);

  @override
  State createState() {
    return AppDrawerState();
  }
}

class AppDrawerState extends State<AppDrawer> {
  final Auth _auth = new Auth();
  var _name = "Loading...";

  @override
  void initState() {
    super.initState();
    print("initState");
    setState(() {
      _auth.getUserName().then((value) => _name = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(_name),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('シフト'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShiftPage()));
            },
//                  Navigator.pushReplacementNamed(context, "/shift"),
          ),
          ListTile(
            leading: Icon(Icons.calendar_view_day),
            title: Text('シフト登録'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShiftRegistrationPage()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              _auth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
              snackBar(context, "ログアウトしました。");
            },
          ),
        ],
      ),
    );
  }
}

snackBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));
  Scaffold.of(context).showSnackBar(snackBar);
}

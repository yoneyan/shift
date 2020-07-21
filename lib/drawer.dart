import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift/login.dart';
import 'package:shift/pages/setting.dart';
import 'package:shift/pages/shift.dart';

import 'auth.dart';
import 'routes.dart';

class AppDrawer extends StatelessWidget {
  final Auth auth;

  const AppDrawer({Key key, this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('シフト登録'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShiftPage()));
            },
//                  Navigator.pushReplacementNamed(context, "/shift"),
          ),
          ListTile(
            leading: Icon(Icons.calendar_view_day),
            title: Text('Messages'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
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
            leading: Icon(Icons.settings),
            title: Text('Logout'),
            onTap: () {
              auth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}

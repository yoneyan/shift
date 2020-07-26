import 'package:flutter/material.dart';
import 'package:shift/pages/shift.dart';

import 'auth.dart';
import 'drawer.dart';
import 'login.dart';
import 'pages/shift.dart';
import 'routes.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Shift',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: RootPage(title: 'Shift', auth: new Auth()),
    routes: {
      Routes.shift: (context) => ShiftPage(),
//      "/shift": (context) => ShiftPage(),
    },
  ));
}

class RootPage extends StatefulWidget {
  RootPage({Key key, this.title, this.auth}) : super(key: key);
  final Auth auth;
  final String title;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool _isLogin = false;

  initState() {
    super.initState();
    widget.auth.checkLogin().then((status) => _isLogin = status);
    print(_isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shift",
//      theme: ThemeData.dark(),
      home: _isLogin ? ShiftPage() : LoginPage(),
    );
  }
}

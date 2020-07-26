import 'package:flutter/material.dart';
import 'package:shift/pages/shift.dart';
import 'package:shift/pages/shiftRegistration.dart';

import 'package:shift/services/auth.dart';
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
    home: LoginPage(),
//    home: RootPage(title: 'Shift', auth: new Auth()),
    routes: {
      Routes.shift: (context) => ShiftPage(),
      Routes.shiftRegistration: (context) => ShiftRegistrationPage(),
//      "/shift": (context) => ShiftPage(),
    },
  ));
}
import 'package:flutter/material.dart';

import '../drawer.dart';

class SettingPage extends StatelessWidget {
  static const String routeName = '/shift';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Center(
        child: Text("Setting Pages"),
      ),
    );
  }

}

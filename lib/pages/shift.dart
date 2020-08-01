import 'package:flutter/material.dart';

import '../drawer.dart';

class ShiftPage extends StatelessWidget {
  static const String routeName = '/shift';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Shift(確定分)"),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text("未実装"),
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:shift/services/auth.dart';

class SettingPage extends StatefulWidget {
  SettingPage();

  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  static const String routeName = '/setting';

  final Auth auth = new Auth();

  final emailInputController = new TextEditingController();
  final passInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    auth.currentUser().then((value) => emailInputController.text = value.email);

    return new Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("パスワードの変更"),
            splashColor: Colors.blue,
            shape: UnderlineInputBorder(),
            onPressed: () {
              auth.changePassword(emailInputController.value.text);
            },
          ),
//          RaisedButton(
//            child: Text("確認メールの送信"),
//            splashColor: Colors.blueGrey,
//            shape: UnderlineInputBorder(),
//            onPressed: () {},
//          ),
        ],
      ),
    );
  }
}

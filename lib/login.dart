import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift/drawer.dart';
import 'package:shift/pages/shift.dart';

import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState(new Auth());
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState(this.auth);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Auth auth;

  final emailInputController = new TextEditingController();
  final passInputController = new TextEditingController();

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _passwordFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: Text('ログインページ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 350,
              child: TextFormField(
                controller: emailInputController,
                decoration: const InputDecoration(hintText: 'E-mail'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'メールアドレスを入力してください';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Container(
                width: 350,
                child: TextFormField(
                  controller: passInputController,
                  focusNode: _passwordFocusNode,
                  decoration: const InputDecoration(hintText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'パスワードを入力してください';
                    }
                    return null;
                  },
                )),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  child: Text('ログイン'),
                  onPressed: () {
                    auth
                        .signIn(emailInputController.value.text,
                            passInputController.value.text)
                        .then((value) => {
                              if (value.uid != null)
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShiftPage()))
                                }
                              else
                                {
                                  _showScaffold("This is a SnackBar called from another place.")
                                }
                            });
                  },
                )),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: RaisedButton(
                  child: Text('Googleログイン'),
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Hello from snackbar",
                          textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0, fontWeight:
                          FontWeight.bold),), duration: Duration(seconds: 3), backgroundColor: Colors.blue,)
                    );
//                    _showScaffold("This is a SnackBar called from another place.");

//                    Navigator.push(context,
//                        MaterialPageRoute(builder: (context) => ShiftPage()));
                  },
                )),
          ],
        ),
      ),
    );
  }
}

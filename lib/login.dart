import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift/pages/shift.dart';

import 'auth.dart';
import 'drawer.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState(new Auth());
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState(this.auth);

  final Auth auth;

  final emailInputController = new TextEditingController();
  final passInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _passwordFocusNode = FocusNode();

    return Scaffold(
        appBar: AppBar(
          title: Text('ログインページ'),
        ),
        body: Builder(
          builder: (context) => Center(
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
                            .then((data) => {
                                  print('data.uid'),
                                  print(data.uid),
                                  if (data.uid != null)
                                    {
                                      print("UID: " + data.uid),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShiftPage()))
                                    }
                                  else
                                    {
                                      snackBar(
                                          context, "メールアドレス又はパスワードが間違っています。")
                                    }
                                })
                            .catchError(() =>
                                snackBar(context, "メールアドレス又はパスワードが間違っています。"));
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: RaisedButton(
                      child: Text('Googleログイン'),
                      onPressed: () => {snackBar(context, "現在、テスト中ため使用不可")},
                    )),
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SnackBarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('お知らせ！'),
            action: SnackBarAction(
              label: 'とじる',
              onPressed: () {
                Scaffold.of(context).removeCurrentSnackBar();
              },
            ),
            duration: Duration(seconds: 3),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('スナックバーを開く'),
      ),
    );
  }
}
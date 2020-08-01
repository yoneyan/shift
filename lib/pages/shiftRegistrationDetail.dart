import 'package:flutter/material.dart';
import 'package:shift/pages/shiftRegistration.dart';
import 'package:shift/services/shift.dart';


//#1 Issue
class ShiftRegistrationDetailPage extends StatefulWidget {
  const ShiftRegistrationDetailPage({
    Key key,
    this.date,
    this.position,
    this.base,
    this.data,
    this.comment,
  }) : super(key: key);
  final DateTime date;
  final String position;
  final List<String> base;
  final String data;

  final String comment;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ShiftRegistrationDetailPage> {
  final ShiftService _shiftService = new ShiftService();
  final commentInputController = new TextEditingController();
  int genre;
  List<String> list = [];
  List<int> listResult = [];
  Map<String, int> _data2 = new Map<String, int>();
  final List<String> _week = ["日", "月", "火", "水", "木", "金", "土"];

  @override
  void initState() {
    super.initState();
    commentInputController.text = widget.comment;

    try {
      if (widget.base[0] == '0') {
        genre = 0;
        for (int i = 1; i < widget.base.length; i++) {
          list.add(widget.base[i]);
        }
      } else if (widget.base[0] == '1') {
        genre = 1;
        for (int i = 1; i < widget.base.length; i++) {
          list.add(widget.base[i]);
        }
      } else if (widget.base[0] == '2') {
        genre = 2;
        for (int i = 1; i < widget.base.length; i++) {
          if (widget.data.split(',')[i - 1] == "2") {
            // △
            _data2[widget.base[i]] = 2;
          } else if (widget.data.split(',')[i - 1] == "1") {
            // ◯
            _data2[widget.base[i]] = 1;
          } else {
            // X
            _data2[widget.base[i]] = 0;
          }
          list.add(widget.base[i]);
        }
      } else {
        genre = 100;
      }
    } catch (err) {
      genre = int.parse(widget.base[0]);
      for (int i = 1; i < widget.base.length; i++) {
        list.add(widget.base[i]);
        _data2[widget.base[i]] = 0;
      }
    }
    setState(() {});
  }

  @override
  void pushRegistration(BuildContext context) {
    Map<String, dynamic> _base = new Map<String, dynamic>();
    Map<String, Map<String, dynamic>> _doc =
        new Map<String, Map<String, dynamic>>();
    String tmp = '';
    _base['position'] = widget.position.toString();
    _base['year'] = widget.date.year;
    _base['month'] = widget.date.month;
    _doc[widget.date.day.toString()] = {
      'comment': commentInputController.value.text
    };

    if (widget.base[0] == "1" || widget.base[0] == "2") {
      for (int i = 1; i < widget.base.length; i++) {
        tmp += _data2[widget.base[i]].toString();
        if (i != widget.base.length - 1) {
          tmp += ',';
        }
      }
      _doc[widget.date.day.toString()] = {'data': tmp};
    }
    print('sendBaseData: $_base');
    print('sendDocData: $_doc');

    _shiftService.registShiftData(_doc, _base).then((value) => {
          if (value)
            {
//              snackBar(context, '登録しました。'),
//              new Future.delayed(new Duration(seconds: 2)).then((value) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShiftRegistrationPage())),
//                  }),
            }
        });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("シフト登録(個別)"),
        ),
        body: Column(children: <Widget>[
          Center(
            child: Text(
                widget.date.year.toString() +
                    '年' +
                    widget.date.month.toString() +
                    "月" +
                    widget.date.day.toString() +
                    "日" +
                    _week[widget.date.weekday] +
                    "曜日",
                style: TextStyle(fontSize: 25)),
          ),
          if (genre == 0) ListTile(),
          if (genre == 1)
            for (int i = 0; i < list.length; i++)
              Card(
//                margin: ,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
//                    detailPages(selectDate);
                  },
                  child: Row(
                    children: <Widget>[
                      Text(' '),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                height: 30,
                                child: Text(list[i]),
                              )
                            ],
                          ),
                        ],
                      )),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => setState(() => _data2[list[i]] = 0),
                              child: Container(
                                height: 56,
                                width: 56,
                                color: _data2[list[i]] == 0
                                    ? Colors.grey
                                    : Colors.transparent,
                                child: Icon(Icons.clear),
                              ),
                            ),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () =>
                                  setState(() => {_data2[list[i]] = 2}),
                              child: Container(
                                height: 56,
                                width: 56,
                                color: _data2[list[i]] == 2
                                    ? Colors.grey
                                    : Colors.transparent,
                                child: Icon(Icons.trip_origin),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          if (genre == 2)
            for (int i = 0; i < list.length; i++)
              Card(
//                margin: ,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
//                    detailPages(selectDate);
                  },
                  child: Row(
                    children: <Widget>[
                      Text(' '),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                height: 30,
                                child: Text(list[i]),
                              )
                            ],
                          ),
                        ],
                      )),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            // X
                            GestureDetector(
                              onTap: () => setState(() => _data2[list[i]] = 0),
                              child: Container(
                                height: 56,
                                width: 56,
                                color: _data2[list[i]] == 0
                                    ? Colors.grey
                                    : Colors.transparent,
                                child: Icon(Icons.clear),
                              ),
                            ),
                            SizedBox(width: 4),
                            // △
                            GestureDetector(
                              onTap: () => setState(() => _data2[list[i]] = 2),
                              child: Container(
                                height: 56,
                                width: 56,
                                color: _data2[list[i]] == 2
                                    ? Colors.grey
                                    : Colors.transparent,
                                child: Icon(Icons.change_history),
                              ),
                            ),
                            SizedBox(width: 4),
                            // ◯
                            GestureDetector(
                              onTap: () =>
                                  setState(() => {_data2[list[i]] = 1}),
                              child: Container(
                                height: 56,
                                width: 56,
                                color: _data2[list[i]] == 1
                                    ? Colors.grey
                                    : Colors.transparent,
                                child: Icon(Icons.trip_origin),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          if (genre == 100)
            Center(
              child: Text('This data is not found...',
                  style: TextStyle(fontSize: 30)),
            ),
          Container(
              width: 350,
              child: TextFormField(
                controller: commentInputController,
                decoration: const InputDecoration(hintText: 'comment'),
              )),
          Center(
            child: RaisedButton(
              child: Text("登録"),
              splashColor: Colors.blue,
              shape: UnderlineInputBorder(),
              onPressed: () {
                pushRegistration(context);
              },
            ),
          )
        ]));
  }
}

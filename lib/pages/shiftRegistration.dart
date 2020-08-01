import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:shift/pages/shiftRegistrationDetail.dart';
import 'package:shift/services/base.dart';

import '../drawer.dart';

class ShiftRegistrationPage extends StatefulWidget {
  @override
  _ShiftRegistrationPageState createState() => _ShiftRegistrationPageState();
}

class _ShiftRegistrationPageState extends State<ShiftRegistrationPage> {
  _ShiftRegistrationPageState();

  final Base base = new Base();

  //#2 Issue
  DateTime selectDate = DateTime.now();
  EventList<Event> _markedDateMap = new EventList<Event>();
  bool status = false;
  Map<String, Map<String, dynamic>> data =
      new Map<String, Map<String, dynamic>>();
  String comment = 'This data is not found.';
  String decided = 'This data is not found.';
  String unknown = 'This data is not found.';

  @override
  void initState() {
    int _year, _month;
    base.getShiftRegistrationData().then((value) => {
          data = value,
          value.forEach((key, value) {
            var tmp = key.split('-');
            _year = int.parse(tmp[0]);
            _month = int.parse(tmp[1]);
            try {
              value.forEach((key, value) {
                int _day = int.parse(key);
                print('day: $_day');
                _markedDateMap.add(
                    new DateTime(_year, _month, _day),
                    new Event(
                        date: new DateTime(_year, _month, _day),
                        title: 'Event 5',
                        icon: Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1000)),
                              border:
                                  Border.all(color: Colors.blue, width: 2.0)),
                          child: new Icon(
                            Icons.person,
                            color: Colors.amber,
                          ),
                        )));
              });
            } catch (err) {
              print('Error: $err');
            }
          }),
          //This code is to update display.
          setState(() {
            status = true;
          }),
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    base.getUser().then((value) => {print(value)});
    String genre = "teacher";

    void onDayPressed(DateTime date, List<Event> events) {
      setState(() {
        try {
          selectDate = date;
          var _monthData =
              data[date.year.toString() + '-' + date.month.toString()];

          decided = _monthData[date.day.toString()]['1'].toString();
          unknown = _monthData[date.day.toString()]['2'].toString();
          comment = _monthData[date.day.toString()]['comment'].toString();
        } catch (err) {
          selectDate = date;
          print("Error: $err");
          comment = 'This data is not found.';
          decided = 'This data is not found.';
          unknown = 'This data is not found.';
        }
      });
    }

    void detailPages(DateTime date) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShiftRegistrationDetailPage(
                  date, genre, decided, unknown, comment)));
    }

    return new Scaffold(
        appBar: AppBar(
          title: const Text("シフト登録"),
        ),
        drawer: AppDrawer(),
        body: Column(children: <Widget>[
          Container(
              child: CalendarCarousel(
            weekendTextStyle: TextStyle(
              color: Colors.red,
            ),
            weekFormat: false,
            selectedDayBorderColor: Colors.green,
            markedDatesMap: _markedDateMap,
            selectedDayButtonColor: Colors.green,
            selectedDayTextStyle: TextStyle(color: Colors.green),
            todayBorderColor: Colors.transparent,
            weekdayTextStyle: TextStyle(color: Colors.black),
            height: 420.0,
            daysHaveCircularBorder: true,
            todayButtonColor: Colors.indigo,
            locale: 'JA',
            onDayPressed: (DateTime date, List<Event> events) {
              onDayPressed(date, events);
            },
            onDayLongPressed: (DateTime date) {
              detailPages(date);
            },
          )),
          Row(
            children: <Widget>[
              Text(' '),
              RaisedButton(
                child: Text("曜日一括登録"),
                color: Colors.orange,
                textColor: Colors.white,
                onPressed: () {
                  selectDate = DateTime.now();
                },
              ),
              Text(' '),
              RaisedButton(
                child: Text("シフト登録"),
                color: Colors.orange,
                textColor: Colors.white,
                onPressed: () {
                  detailPages(selectDate);
                },
              ),
            ],
          ),
          Text(selectDate.year.toString() +
              '年' +
              selectDate.month.toString() +
              '月' +
              selectDate.day.toString() +
              '日'),
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                detailPages(selectDate);
              },
              child: Container(
                width: 300,
                height: 100,
                child: Text('◯: $decided\n△: $unknown\nComment: $comment'),
              ),
            ),
          )
        ]));
  }
}

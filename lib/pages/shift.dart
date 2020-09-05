import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:shift/services/base.dart';

import '../drawer.dart';

class ShiftPage extends StatefulWidget {
  @override
  _ShiftPageState createState() => _ShiftPageState();
}

class _ShiftPageState extends State<ShiftPage> {
  static const String routeName = '/shift';
  final Base base = new Base();

  //#2 Issue
  DateTime selectDate = DateTime.now();
  EventList<Event> _markedDateMap = new EventList<Event>();
  bool status = false;

  Map<String, dynamic> data = new Map<String, dynamic>();

  String comment = 'This data is not found.';
  String shift = 'This data is not found.';
  String commentTmp = '';

  //genre(tmp)
  String position = "0";
  List<String> _baseShift = new List<String>();

  int genre = 0;

  @override
  void initState() {
    base.getShiftData(position).then((value) => {
          _baseShift = value,
        });
    int _year, _month;
    base.getShiftConfirmData("0").then((value) => {
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

    void refreshShiftData(DateTime date) {
      // print("data: $data");
      //
      // var _data = data;

      try {
        //initialize
        shift = "";
        comment = "";
        commentTmp = "";

        selectDate = date;

        //シフト記入されてるデータを,ごとにList型の_dataに格納する処理
        print('baseData: $data');
        List<dynamic> _data = new List<dynamic>();

        _data = data[date.year.toString() + '-' + date.month.toString()]
            [date.day.toString()]['data'];
        print(_data);

        for (int i = 0; i < _data.length; i++) {
          String tmp = _data[i]['time'] + ' ' + _data[i]['comment'] + "\n";
          shift += tmp;
        }
        commentTmp = comment;
      } catch (err) {
        //process error
        selectDate = date;
        print("Error: $err");
        comment = 'This data is not found.';
        commentTmp = '';
      }
    }

    void onDayPressed(DateTime date, List<Event> events) {
      setState(() {
        refreshShiftData(date);
      });
    }

    void detailPages(DateTime date) {
      // setState(() {
      //   refreshShiftData(date);
      //   var _monthData =
      //       data[date.year.toString() + '-' + date.month.toString()];
      //   var tmp;
      //   try {
      //     tmp = _monthData[date.day.toString()]['data'];
      //   } catch (err) {
      //     tmp = null;
      //   }
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => ShiftRegistrationDetailPage(
      //                 date: date,
      //                 base: _baseShift,
      //                 position: position,
      //                 data: tmp,
      //                 comment: commentTmp,
      //               )));
      // });
    }

    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("シフト確定分"),
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
                    child: Text('$shift\nComment: $comment'),
                  ),
                ),
              )
            ])));
  }
}

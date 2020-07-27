import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:shift/pages/shiftRegistrationDetail.dart';

import '../drawer.dart';

class ShiftRegistrationPage extends StatefulWidget {
  @override
  _ShiftRegistrationPageState createState() => _ShiftRegistrationPageState();
}

class _ShiftRegistrationPageState extends State<ShiftRegistrationPage> {
  static const String routeName = '/shiftRegistration';

  DateTime _currentDate = DateTime.now();
  DateTime selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    void onDayPressed(DateTime date, List<Event> events) {
      setState(() {
        selectDate = date;
      });
    }

    void detailPages(DateTime date) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShiftRegistrationDetailPage()));
    }

    return new Scaffold(
        appBar: AppBar(
          title: const Text("シフト登録"),
        ),
        drawer: AppDrawer(),
        body: Column(children: <Widget>[
          Container(
            child: CalendarCarousel<Event>(
                headerMargin: EdgeInsets.symmetric(),
                locale: 'JA',
                onDayPressed: (DateTime date, List<Event> events) {
                  onDayPressed(date, events);
                },
                weekendTextStyle: TextStyle(color: Colors.red),
//                thisMonthDayBorderColor: Colors.grey,
                weekFormat: false,
                height: 400.0,
                selectedDateTime: _currentDate,
                daysHaveCircularBorder: false,
                customGridViewPhysics: NeverScrollableScrollPhysics(),
                markedDateShowIcon: true,
                markedDateIconMaxShown: 2,
                todayTextStyle: TextStyle(
                  color: Colors.blueAccent,
                ),
                markedDateIconBuilder: (event) {
                  return event.icon;
                },
                todayBorderColor: Colors.lightGreen,
                onDayLongPressed: (DateTime date) {
                  detailPages(date);
                },
                markedDateMoreShowTotal: false),
          ),
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
                onPressed: () {},
              ),
            ],
          ),
          Text(selectDate.year.toString() +
              '年' +
              selectDate.month.toString() +
              '月' +
              selectDate.day.toString() +
              '日'),
        ]));
  }
}

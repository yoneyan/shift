import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../drawer.dart';

class ShiftRegistrationPage extends StatelessWidget {
  static const String routeName = '/shiftRegistration';

  DateTime _currentDate = DateTime.now();

  void onDayPressed(DateTime date, List<Event> events) {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("シフト登録"),
        ),
        drawer: AppDrawer(),
        body: Column(children: <Widget>[
          Container(
            child: CalendarCarousel<Event>(
                onDayPressed: onDayPressed,
                weekendTextStyle: TextStyle(color: Colors.red),
                thisMonthDayBorderColor: Colors.grey,
                weekFormat: false,
                height: 450.0,
                selectedDateTime: _currentDate,
                daysHaveCircularBorder: false,
                customGridViewPhysics: NeverScrollableScrollPhysics(),
                markedDateShowIcon: true,
                markedDateIconMaxShown: 2,
                todayTextStyle: TextStyle(
                  color: Colors.blue,
                ),
                markedDateIconBuilder: (event) {
                  return event.icon;
                },
                todayBorderColor: Colors.green,
                markedDateMoreShowTotal: false),
          ),
        ]));
  }
}

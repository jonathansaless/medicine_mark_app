import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class MedicineDetailsPage extends StatefulWidget {
  final String medicine;

  MedicineDetailsPage({required this.medicine});

  @override
  _MedicineDetailsPageState createState() => _MedicineDetailsPageState();
}

class _MedicineDetailsPageState extends State<MedicineDetailsPage> {
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<dynamic>> _markedDates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcar ${widget.medicine} como Tomado'),
      ),
      body: Center(
        child: TableCalendar(
          calendarFormat: CalendarFormat.month,
          focusedDay: _selectedDate,
          firstDay: DateTime.utc(2022, 1, 1),
          lastDay: DateTime.utc(2025, 12, 31),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
          ),
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, date, events) => buildDayWidget(date, Colors.blue),
            todayBuilder: (context, date, events) => buildDayWidget(date, Colors.redAccent),
            markerBuilder: (context, date, events) {
              if (_markedDates[date] != null && _markedDates[date]!.contains('taken')) {
                return buildDayWidget(date, Colors.green);
              }
              return null;
            },
          ),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDate = selectedDay;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String key = '${widget.medicine}_${_selectedDate.year}_${_selectedDate.month}_${_selectedDate.day}';
          prefs.setBool(key, true);

          setState(() {
            _markedDates[_selectedDate] = ['taken'];
          });

          Navigator.pop(context);
        },
        child: Icon(Icons.check),
      ),
    );
  }

  Widget buildDayWidget(DateTime date, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          date.day.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


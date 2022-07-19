// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers
import 'package:calendar_app/pages/createEvent.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 27, elevation: 0, backgroundColor: const Color(0xff79d598)),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
        ),
      ),
      body: buildStack(height, context),
    );
  }

  Stack buildStack(double height, BuildContext context) {
    return Stack(children: [
      Container(
        //margin: EdgeInsets.only(top: 27.5),
        decoration: const BoxDecoration(color: Color(0xff79d598)),
        height: height - 360,
        child: TableCalendar(
          onDaySelected: (DateTime selectday, DateTime focusday) {
            setState(() {
              selectedDay = selectday;
              focusedDay = focusday;
            });
          },
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          calendarFormat: format,
          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              format = _format;
            });
          },
          calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                  border: Border.all(width: 1),
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff79d598)),
              todayDecoration:const  BoxDecoration(
                  shape: BoxShape.circle,
                 // borderRadius: BorderRadius.circular(15),
                  color:  Color(0xff3dc26c))),
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: focusedDay,
        ),
      ),
      Container(
        height: height,
        margin: EdgeInsets.only(top: height / 2),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 255, 127, 80),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateEvent()));
                },
                child: const Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}

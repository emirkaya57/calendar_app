import 'package:calendar_app/models/model.dart';
import 'package:calendar_app/pages/EventWidget.dart';
import 'package:calendar_app/pages/createEvent.dart';
import 'package:calendar_app/users/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime(2022 - 07 - 28);
  DateTime focusedDay = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? aciklama;
  String? title;
  DateTime? date;
  String? location;
  @override
  void initState() {
    super.initState();
    getData(selectedDay);
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
    getData(selectedDay);
  }

  void handleData(date) {
    setState(() {
      selectedDay = date;
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 127, 80),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateEvent(),
            ),
          ).then((value) {
            if (value is Event) {
              //ListbuilderWidget();
              debugPrint('Title ::::: ' + value.getTitle);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
            ),
          ],
          automaticallyImplyLeading: false,
          toolbarHeight: 30,
          elevation: 0,
          backgroundColor: const Color(0xff5b5b5b)),
      body: buildStack(height, context),
    );
  }

  Widget buildStack(double height, BuildContext context) {
    // debugPrint('Provider verisi ::: ' +
    //     (Provider.of<Event>(context).getTitle ?? 'kayıtlı veri yok'));
    return Column(
      children: [
        Container(
          // margin: const EdgeInsets.only(top: 27.5),
          decoration: const BoxDecoration(color: Color(0xff5b5b5b)),
          height: height * 0.6,
          child: TableCalendar(
            onPageChanged: (focDay) {
              setState(() {
                focusedDay = focDay;
              });
            },
            onDaySelected: (DateTime date, DateTime selectedDate) {
              if (selectedDay == selectedDate) {
                handleData(selectedDate);

                //const EventWidget();
              }
              setState(() {
                selectedDay = selectedDate;
                getData(selectedDate);
              });
            },
            // eventLoader: _getEventfromDay,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            calendarFormat: format,
            onFormatChanged: (CalendarFormat format) {
              setState(() {
                format = format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: const HeaderStyle(
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
                rightChevronIcon:
                    Icon(Icons.chevron_right, color: Colors.white),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 21)),
            calendarStyle: CalendarStyle(
                outsideTextStyle: const TextStyle(color: Colors.white),
                defaultTextStyle: const TextStyle(color: Colors.amber),
                weekendTextStyle: const TextStyle(color: Colors.amber),
                selectedDecoration: BoxDecoration(
                    border: Border.all(width: 1),
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff5b5b5b)),
                selectedTextStyle: const TextStyle(color: Colors.white),
                todayTextStyle: const TextStyle(color: Color(0xff5b5b5b)),
                todayDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(15),
                    color: Colors.white)),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: focusedDay,
          ),
        ),
        const EventWidget()
      ],
    );
  }

  getData(selectDay) async {
    if (selectedDay == selectDay) {
      CollectionReference userRef =
          FirebaseFirestore.instance.collection('users');
      await userRef
          .where(
            'tarih',
            isGreaterThanOrEqualTo: selectDay,
          )
          .where('açıklama', isEqualTo: aciklama)
          .get()
          .then((value) {
        for (var element in value.docs) {
          debugPrint('::::: ${(element.data() as Map?)?['konum'] ?? ''}');

          /*  Column(
          children: [
            Text((element.data() as Map?)?['başlık'] ?? ''),
            Text((element.data() as Map?)?['açıklama'] ?? ''),
            Text((element.data() as Map?)?['title'] ?? ''),
          ],
        ); */
        }
      });
    } else {
      debugPrint('::::: else');
    }

    return Container();
  }
}

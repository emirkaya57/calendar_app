import 'package:calendar_app/models/eventMOdel.dart';
import 'package:calendar_app/models/model.dart';
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
  List<EventModel> eventList = [];
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? aciklama;
  String? title;
  DateTime? date;
  String? location;
  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
    //getData();
  }

  /*  Future getData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    String aciklama = await userDoc.get('açıklama');
    String title = await userDoc.get('başlık');
    String location = await userDoc.get('konum');
    debugPrint('title $title');
  } */

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

  Stack buildStack(double height, BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    // debugPrint('Provider verisi ::: ' +
    //     (Provider.of<Event>(context).getTitle ?? 'kayıtlı veri yok'));
    return Stack(
      children: [
        Container(
          // margin: const EdgeInsets.only(top: 27.5),
          decoration: const BoxDecoration(color: Color(0xff5b5b5b)),
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
        Container(
          height: height,
          margin: EdgeInsets.only(top: height / 2),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: const EventWidget(),

          /* StreamBuilder<QuerySnapshot>(
            stream: dataStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {}
              if (snapshot.connectionState == ConnectionState.waiting) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List dataDocs = [];
              snapshot.data?.docs.map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                dataDocs.add(a);
                a['id'] = document.id;
              }).toList();

              return ListView.builder(
                itemCount: dataDocs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey.shade700,
                      width: 1,
                    )),
                    child: Column(
                      children: [
                        Text(
                          dataDocs[index]['başlık'].toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          dataDocs[index]['açıklama'].toString(),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ), */
        )
      ],
    );
  }
}

class EventWidget extends StatefulWidget {
  const EventWidget({Key? key}) : super(key: key);

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {}
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        List dataDocs = [];
        snapshot.data?.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          dataDocs.add(a);
          a['id'] = document.id;
        }).toList();
        return ListView.builder(
          itemCount: dataDocs.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade700,
                    width: 1,
                  )),
              child: Container(
                margin: const EdgeInsets.only(right: 5, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dataDocs[index]['başlık'].toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      dataDocs[index]['açıklama'].toString(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(dataDocs[index]['konum'].toString(),
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w600))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
/*  ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 10),
                width: 100,
                height: 50,
                color: Colors.orange,
                child: Column(
                  children: [],
                ),
              );
            },
          ), */
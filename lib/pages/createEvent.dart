// ignore_for_file: file_names
import 'package:calendar_app/models/eventMOdel.dart';
import 'package:calendar_app/pages/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/model.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  DateTime dateTime = DateTime(2022, 07, 21);
  TimeOfDay time = const TimeOfDay(hour: 11, minute: 28);
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController locationController;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Create Event',
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: const Color(0xff5b5b5b),
          elevation: 0),
      body: eventStack(context),
    );
  }

  Widget eventStack(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height / 8,
          decoration: const BoxDecoration(
            color: Color(0xff5b5b5b),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 78),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(15))),
          child: Column(
            children: [
              buildTitle(),
              buildCalculatorandClock(context),
              const SizedBox(
                height: 10,
              ),
              buildLocation(),
              buildDescription(),
              InkWell(
                onTap: () {
                  veriekle();
                  EventWidget();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      color: const Color(0xfff4ae06),
                      //const Color.fromARGB(255, 255, 127, 80),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    'Ekle',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget buildCalculatorandClock(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () async {
            var newTime = await showDatePicker(
                context: context,
                initialDate: dateTime,
                firstDate: DateTime(1900),
                lastDate: DateTime(2222));
            if (newTime == null) {
              return;
            }
            setState(() {
              dateTime = newTime;
            });
          },
          child: Row(children: [
            Text(
              '${dateTime.day}/${dateTime.month}/${dateTime.year}',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.calendar_month_outlined,
              color: Colors.black,
            ),
          ]),
        ),
        TextButton(
            onPressed: () async {
              var newclockTime =
                  await showTimePicker(context: context, initialTime: time);
              if (newclockTime == null) {
                return;
              }
              setState(() {
                time = newclockTime;
              });
            },
            child: Row(
              children: [
                Text(
                  '${time.hour}:${time.minute}',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.access_time,
                  color: Colors.black,
                )
              ],
            )),
      ],
    );
  }

  Container buildTitle() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          //blurStyle: BlurStyle.solid,
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(15), color: Colors.white),
      height: 45,
      margin: const EdgeInsets.all(35),
      child: TextField(
        controller: titleController,
        // onChanged: (s) {
        //   Provider.of<Event>(context, listen: false).setTitle = s;
        // },
        decoration: const InputDecoration(
          label: Text(
            'Konu Başlığı',
            style: TextStyle(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              //  style: BorderStyle.none,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              //  style: BorderStyle.none,
              color: Colors.grey,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              //  style: BorderStyle.none,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Container buildLocation() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          //blurStyle: BlurStyle.solid,
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(15), color: Colors.white),
      height: 45,
      margin: const EdgeInsets.only(top: 15, right: 35, left: 35),
      child: TextField(
        controller: locationController,
        cursorColor: Colors.black,
        decoration: const InputDecoration(
          label: Text(
            'Konum',
            style: TextStyle(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              //  style: BorderStyle.none,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              //  style: BorderStyle.none,
              color: Colors.grey,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              //  style: BorderStyle.none,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Container buildDescription() {
    return Container(
      height: 100,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          //blurStyle: BlurStyle.solid,
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(top: 20, right: 35, left: 35),
      child: TextField(
        controller: descriptionController,
        cursorColor: Colors.black,
        maxLines: 15,
        decoration: const InputDecoration(
          label: Text(
            'Açıklama',
            style: TextStyle(color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void veriekle() async {
    Map<String, dynamic> eklenecekUser = <String, dynamic>{};
    eklenecekUser['başlık'] = titleController.text;
    eklenecekUser['konum'] = locationController.text;
    eklenecekUser['tarih'] = DateFormat('yyyy-MM-dd').format(dateTime);
    // eklenecekUser['saat'] = time;
    eklenecekUser['açıklama'] = descriptionController.text;
    var token = auth.currentUser!.uid;
    await firestore.doc('users/$token').set(eklenecekUser).then((value) {
      Navigator.pop(
        context,
        Event.allParameters(titleController.text, DateTime.now(),
            locationController.text, descriptionController.text),
      );
    });
  }
}

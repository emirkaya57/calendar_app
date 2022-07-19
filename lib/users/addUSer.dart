import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String title;
  final TimeOfDay clock;
  final DateTime date;
  final String description;
  final String location;

  AddUser(
      this.title, this.clock, this.date, this.description, this.location);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    addUser() {
      return users
          .add({
            'title': title,
            'clock': clock,
            'date': date,
            'description': description,
            'location' : location
          })
          .then((value) => debugPrint('user added'))
          .catchError((error) => debugPrint('failed add user'));
    }

    return addUser() as Widget;
  }
}

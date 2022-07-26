import 'package:flutter/material.dart';

class Event extends ChangeNotifier {
  Event();
  Event.allParameters(this.title, this.date, this.location, this.description);

  String? title;
  DateTime? date;
  String? location;
  String? description;

  get getTitle => title;

  set setTitle(title) {
    title = title;
    notifyListeners();
  }

  get getDate => date;

  set setDate(date) {
    date = date;
    notifyListeners();
  }

  get getLocation => location;

  set setLocation(location) {
    location = location;
    notifyListeners();
  }

  get getDescription => description;

  set setDescription(description) {
    description = description;
    notifyListeners();
  }
}

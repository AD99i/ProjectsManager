import 'package:flutter/material.dart';
import 'package:tp/model/Task.dart';

enum ProjectStatus { enCours, termine, aVenir }

class Project {
  String _title;
  String _desc;
  ProjectStatus _status;
  DateTime? _date;
  List<Task>? _tasks;

  Project(
      {required String title,
      required String desc,
      ProjectStatus status = ProjectStatus.aVenir,
      DateTime? date,
      List<Task>? tasks})
      : _title = title,
        _desc = desc,
        _status = status,
        _date = date,
        _tasks = tasks;


  set title(String value) {
    _title = value;
  }

  String get title => _title;

  set desc(String value) {
    _desc = value;
  }

  String get desc => _desc;

  set status(ProjectStatus value) {
    _status = value;
  }

  ProjectStatus get status => _status;

  set date(DateTime? date) {
    _date = date;
  }

  DateTime? get date => _date;

  List<Task>? get tasks => _tasks;

  set tasks(List<Task> value) {
    _tasks = value;
  }


}


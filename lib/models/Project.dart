import 'package:flutter/material.dart';

enum ProjectStatus { enCours, termine, aVenir }

class Project {
  String _title;
  String _desc;
  ProjectStatus _status;
  DateTime? _date;

  Project(
      {required String title,
      required String desc,
      ProjectStatus status = ProjectStatus.aVenir,
      DateTime? date})
      : _title = title,
        _desc = desc,
        _status = status,
        _date = date;

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
}

import 'package:flutter/material.dart';

class Project {
  String _title;
  String _desc;

  Project({required String title, required String desc})
      : _title = title,
        _desc = desc;

  set title(String value) {
    _title = value;
  }

  String get title => _title;

  set desc(String value) {
    _desc = value;
  }

  String get desc => _desc;
}

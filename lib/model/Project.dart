import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Task.dart';

enum ProjectStatus { enCours, termine, aVenir }

class Project {
  Key _key;
  String _title;
  String _desc;
  ProjectStatus _status;
  DateTime? _date;
  List<Task> _tasks = [];

  Project({
      required String title,
      required String desc,
      ProjectStatus status = ProjectStatus.aVenir,
      DateTime? date})
      : _title = title,
        _desc = desc,
        _status = status,
        _date = date,
        _key = UniqueKey()
  ;

  Key get key => _key;

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

  List<Task> get tasks => _tasks;

  set tasks(List<Task> tasks) {
    _tasks = tasks;
  }

  Future<List<Task>> initTasks() async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1/todos'));

    if(response.statusCode == 200) {
       _tasks = List<Task>.from(jsonDecode(response.body).map((data) => Task.fromJson(data)).toList());
    }

    return _tasks;
  }

  void removeTask(Task task) {
    _tasks = _tasks.where((t) => t != task).toList();
  }
}

import 'package:flutter/material.dart';
import '../model/Project.dart';

class ProjectProvider extends ChangeNotifier
{

  List<Project> _projects = [
    Project(
        title: 'Projet Mannhattan',
        desc: 'un projet vraiment énorme',
        date: DateTime(2025, 12, 25)),
    Project(title: 'Projet important', desc: 'un projet très important'),
  ];

  List<Project> get projects => _projects;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  void updateProject(Project project) {
    final index = _projects.indexWhere((p) => p.key == project.key);

    if (index != -1) {
      _projects[index] = project;
      notifyListeners();
    }
  }


}
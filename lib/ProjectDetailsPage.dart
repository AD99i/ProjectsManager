import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp/utils/Utils.dart';
import 'model/Project.dart';
import 'ContributionPage.dart';

class ProjectDetailsPage extends StatefulWidget {
  final Project project;

  const ProjectDetailsPage({
    required this.project,
  });

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  late Project _project = widget.project;

  String _statusToString(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.enCours:
        return 'En cours';
      case ProjectStatus.termine:
        return 'Terminé';
      case ProjectStatus.aVenir:
        return 'A venir';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_project.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              context.go('/update', extra: _project);
            },
          ),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text(
          'Statut : ${_statusToString(_project.status)}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
        ),
        Text(
          _project.date != null
              ? 'Date de début : ${formatDate(_project.date)}'
              : '',
        ),
        Text(_project.desc,
            style: TextStyle(fontSize: 16, color: Colors.indigo)),
      ]),
    );
  }
}

class EditProject extends StatelessWidget {
  Project _project;
  BuildContext context;

  EditProject(this.context, {required Project project}) : _project = project;

  void _onUpdate(Project project) {
    // Persistance éventuelle de la maj

    context.go('/');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Projet "${project.title}" updated !')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_project.title),
        centerTitle: true,
      ),
      body: ContributionPage(onProjectSubmitted: _onUpdate, project: _project),
    );
  }
}

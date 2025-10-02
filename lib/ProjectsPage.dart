import 'package:flutter/material.dart';
import 'models/Project.dart';

class ProjectsPage extends StatelessWidget {
  final List<Project> _projects;

  const ProjectsPage({required projects}) : _projects = projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _projects.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final project = _projects[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: const Icon(Icons.work_outline, color: Colors.indigo),
            title: Text(project.title),
            subtitle: Text(project.desc),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        );
      },
    );
  }
}

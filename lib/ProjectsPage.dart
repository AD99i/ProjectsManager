import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/ProjectProvider.dart';


class ProjectsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final projectProvider = Provider.of<ProjectProvider>(context);

    return ListView.builder(
      itemCount: projectProvider.projects.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final project = projectProvider.projects[index];

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
            onTap: () {
              context.go('/details', extra: project);
            },
          ),
        );
      },
    );
  }
}

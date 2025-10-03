import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'model/Project.dart';
import 'model/Task.dart';
import 'ContributionPage.dart';
import 'utils/utils.dart';


class ProjectDetailsPage extends StatefulWidget {
  final Project project;

  const ProjectDetailsPage({
    super.key,
    required this.project,
  });

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  late Project _project = widget.project;
  late List<Task> _tasks = [];
  bool _isDisplay = false;

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
  void initState() {
    super.initState();
    if (_project.tasks.isEmpty) {
      _isDisplay = true;
      initTasks();
    } else {
      _tasks = _project.tasks;
    }
  }

  Future<void> initTasks() async {
    var tasks = await _project.initTasks();
    setState(() {
      _isDisplay = false;
      _tasks = tasks;
    });
  }

  void _addDetail(Task task, String detail) {
    setState(() {
      task.addDetail(detail);
    });
  }

  void _showAddDetailDialog(Task task) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Ajouter un détail à ${task.name}'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: 'Detail'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _addDetail(task, controller.text.trim());
              }
              Navigator.pop(context);
            },
            child: Text('Ajouter'),
          ),
        ],
      ),
    );
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
        WaitingSpinner(display: _isDisplay),
        ..._tasks.map((task) => Card(
          child: ListTile(
            title: Text(task.name, style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),),
            subtitle: task.isCompleted
                ? Text('Tâche complétée', style: TextStyle(color: Colors.green))
                : (task.details.isEmpty ? Text('Aucun détail') : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    task.details!.map((d) => Text('- $d')).toList(),
            )),
            leading: task.isCompleted ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.chevron_right, color: Colors.yellow),
            trailing: Wrap(
              spacing: 12.0,
              children: [
                IconButton(onPressed: () {
                  setState(() {
                    task.isCompleted = !task.isCompleted;
                  });
                }, icon: task.isCompleted ? Icon(Icons.autorenew_sharp) : Icon(Icons.check_box, color: Colors.yellow)),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'addDetail') {
                      _showAddDetailDialog(task);
                    } else if (value == 'remove') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Voulez-vous vraiment supprimer ?'),
                          action: SnackBarAction(
                            label: 'Confirmer',
                            onPressed: () {
                              setState(() {
                                _project.removeTask(task);
                              });
                              // Action à faire lors de la confirmation
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Élément supprimé')),
                              );
                            },
                          )));
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'addDetail',
                      child: Text('Ajouter des détails'),
                    ),
                    PopupMenuItem(
                      value: 'remove',
                      child: Text('Supprimer tâche'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ]),

    );
  }
}

class EditProject extends StatelessWidget {
  final Project _project;
  final BuildContext context;

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

class WaitingSpinner extends StatefulWidget
{
  bool _display;

  WaitingSpinner({bool display = false }) : _display = display;

  @override
  State<WaitingSpinner> createState() => _WaitingSpinnerState();
}

class _WaitingSpinnerState extends State<WaitingSpinner> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget._display) {
      // Si items est null, on est en attente => afficher spinner
      return Center(child: CircularProgressIndicator());
    };
    return Center();
  }
}

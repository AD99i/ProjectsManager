import 'package:flutter/material.dart';
import 'model/Project.dart';
import 'utils/Utils.dart';

class ContributionPage extends StatefulWidget {
  final Function(Project) onProjectSubmitted;

  final Project? project;

  ContributionPage({required this.onProjectSubmitted, this.project});

  @override
  _ContributionPageState createState() => _ContributionPageState();
}

class _ContributionPageState extends State<ContributionPage> {

  final _formKey = GlobalKey<FormState>();
  late Project? project;
  String? _title;
  String? _desc;
  ProjectStatus _status = ProjectStatus.aVenir;
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final project = Project(
        title: _title ?? '',
        desc: _desc ?? '',
        status: _status,
        date: _selectedDate,
      );

      widget.onProjectSubmitted(project);
      _formKey.currentState!.reset();
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    setState(() {
      _selectedDate = pickedDate;
      _dateController.text = formatDate(_selectedDate);
    });
  }

  @override
  void initState() {
    super.initState();
    project = widget.project;
    if (project != null) {
      _selectedDate = project!.date;
      _dateController.text = formatDate(_selectedDate);
    }
  }

  @override
  void dispose() {
    _dateController.dispose(); // Toujours disposer du controller !
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              cursorColor: Colors.black,
              initialValue: project?.title ?? _title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold, // couleur du texte saisi
              ),
              decoration: InputDecoration(
                  labelText: 'Titre du projet',
                  border: OutlineInputBorder(),
                  focusColor: Colors.black,
                  hintStyle: TextStyle(color: Colors.black)),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Champ requis' : null,
              onSaved: (value) {
                _title = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 4,
              initialValue: project?.desc ?? _desc,
              style: TextStyle(
                color: Colors.black, // couleur du texte saisi
              ),
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Champ requis' : null,
              onSaved: (value) {
                _desc = value;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<ProjectStatus>(
              initialValue: project?.status ?? _status,
              style: TextStyle(
                color: Colors.black,
              ),
              dropdownColor: Colors.white,
              decoration: const InputDecoration(labelText: 'Statut'),
              items: [
                const DropdownMenuItem(
                  value: ProjectStatus.enCours,
                  child: Text('En cours'),
                ),
                const DropdownMenuItem(
                  value: ProjectStatus.termine,
                  child: Text('Terminé'),
                ),
                const DropdownMenuItem(
                  value: ProjectStatus.aVenir,
                  child: Text('A venir'),
                ),
              ],
              onChanged: (value) {
                _status = value ?? ProjectStatus.aVenir;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              controller: _dateController,
              onTap: _selectDate,
              decoration: InputDecoration(
                labelText: 'Date de début',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.black, // couleur du texte saisi
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Champ requis' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: Icon(Icons.send),
              label: Text('Soumettre'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

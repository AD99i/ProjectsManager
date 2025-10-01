import 'package:flutter/material.dart';
import 'models/Project.dart';

void main() {
  runApp(
    ProjectManagerApp(),
  );
}

class ProjectManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de Projets',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xffeceaea),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.indigo),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 1,
        ),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();


}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;




  final GlobalKey<_ProjectListViewState> _projectListKey = GlobalKey();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ProjectListView(key: _projectListKey),
      ContributionPage(onProjectSubmitted: switchToProjectsPage),
    ];
  }

  void switchToProjectsPage() {
    setState(() {
      currentPageIndex = 0;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Projets"),
        centerTitle: true,
        leading: const Icon(Icons.rocket_launch_rounded),
      ),
      body: _pages[currentPageIndex],
      floatingActionButton: currentPageIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          _projectListKey.currentState?.addProject();
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      )
          : null,


      bottomNavigationBar: BottomNavigationBar(

        onTap: (int index){
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_open),
            label: 'Projets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Contribuer',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}


class ProjectListView extends StatefulWidget {
  const ProjectListView({Key? key}) : super(key: key);

  @override
  State<ProjectListView> createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {


  late int _projectCounter = projects.length;

  void addProject() {
    setState(() {
      projects.add(Project(
        title: 'Projet n° $_projectCounter',
        desc: 'Description du projet $_projectCounter',
        date: DateTime.now(),
        status: ProjectStatus.enCours,
      ));
      _projectCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final project = projects[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(Icons.work_outline, color: Theme.of(context).primaryColor),
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


class ContributionForm extends StatefulWidget {
  final VoidCallback onSubmitted;

  const ContributionForm({required this.onSubmitted});

  @override
  State<ContributionForm> createState() => _ContributionFormState();
}

class _ContributionFormState extends State<ContributionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  ProjectStatus? _selectedStatus;
  DateTime? _selectedDate;

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _selectedStatus != null &&
        _selectedDate != null) {
      final newProject = Project(
        title: _titleController.text,
        desc: _descController.text,
        date: _selectedDate!,
        status: _selectedStatus!,
      );

      projects.add(newProject);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Le projet "${newProject.title}" a été créé')),
      );

      widget.onSubmitted(); // Retour à la liste
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(Duration(days: 365)),
      lastDate: now.add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Titre du projet',
              labelStyle: TextStyle(
                color: Colors.indigo,
                fontSize: 25, // ← taille du label
                fontWeight: FontWeight.w700,
              ),

            ),
            style: TextStyle(color: Colors.black),
            validator: (value) =>
            value == null || value.isEmpty ? 'Champ obligatoire' : null,
          ),

          TextFormField(
            controller: _descController,
            decoration: InputDecoration(
              labelText: 'Description du projet',
              labelStyle: TextStyle(
                color: Colors.indigo,
                fontSize: 25, // ← taille du label
                fontWeight: FontWeight.w700,
              ),

            ),
            style: TextStyle(color: Colors.black),
            validator: (value) =>
            value == null || value.isEmpty ? 'Champ obligatoire' : null,
          ),

          DropdownButtonFormField<ProjectStatus>(
            initialValue: _selectedStatus,
            items: ProjectStatus.values
                .map((status) => DropdownMenuItem(
              value: status,
              child: Text(status.name, style: TextStyle(color: Colors.black)),
            ))
                .toList(),
            onChanged: (value) => setState(() => _selectedStatus = value),
            decoration: InputDecoration(
              labelText: 'Statut',
              labelStyle: TextStyle(
                color: Colors.indigo,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),

            ),
            style: TextStyle(color: Colors.black),
            dropdownColor: Colors.indigo,
            validator: (value) =>
            value == null ? 'Veuillez choisir un statut' : null,
          ),

          SizedBox(height: 16),
          ListTile(
            title: Text(
              _selectedDate == null
                  ? 'Choisir une date'
                  : 'Date sélectionnée : ${_selectedDate!.toLocal().toString().split(' ')[0]}',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.calendar_today, color: Colors.black),
            onTap: _pickDate,
          ),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Soumettre'),
          ),
        ],
      ),
    );
  }
}
class ContributionPage extends StatelessWidget {
  final VoidCallback onProjectSubmitted;

  const ContributionPage({required this.onProjectSubmitted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContributionForm(onSubmitted: onProjectSubmitted),
    );
  }
}


final List<Project> projects = [
  Project(title: 'Projet n° 1', desc: 'Description du projet 1',date: DateTime.now(),status: ProjectStatus.enCours),
  Project(title: 'Projet n° 2', desc: 'Description du projet 2', date: DateTime.now(),status: ProjectStatus.termine),
  Project(title: 'Projet n° 3', desc: 'Description du projet 3', date: DateTime.now(),status: ProjectStatus.aVenir),
];
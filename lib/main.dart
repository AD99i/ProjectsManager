import 'package:flutter/material.dart';
import 'ContributionPage.dart';
import 'ProjectsPage.dart';
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
        primarySwatch: Colors.indigo,
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
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Project> _projects = [
    Project(title: 'Projet Mannhattan', desc: 'un projet vraiment énorme'),
    Project(title: 'Projet important', desc: 'un projet très important'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSubmit(Project project) {
    setState(() {
      _projects.add(project);
      _selectedIndex = 0;
    });
	
	ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Projet "${project.title}" ajouté !')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Mes Projets" : "Contribuer"),
        centerTitle: true,
        leading: const Icon(Icons.rocket_launch_rounded),
      ),
      body: _selectedIndex == 0
          ? ProjectsPage(projects: _projects)
          : ContributionPage(onProjectSubmitted: _onSubmit),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        tooltip: 'Adding Project',
        onPressed: () {
          setState(() {
            int num = _projects.length + 1;
            _projects
                .add(Project(title: 'New Projet $num', desc: 'nouveau projet'));
          });
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

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

class HomeScreen extends StatelessWidget {
  final List<Project> _projects = [
    Project(title: 'Projet Mannhattan', desc: 'un projet vraiment énorme'),
    Project(title: 'Projet important', desc: 'un projet très important'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Projets"),
        centerTitle: true,
        leading: const Icon(Icons.rocket_launch_rounded),
      ),
      body: ListView.builder(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: null,
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

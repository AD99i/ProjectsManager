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
      ContributionPage(),
    ];
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

class ContributionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("page de contribution"),
    );
  }

}

class ProjectListView extends StatefulWidget {
  const ProjectListView({Key? key}) : super(key: key);

  @override
  State<ProjectListView> createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {
  final List<Project> _projects = [
    Project(title: 'Projet n° 1', desc: 'Description du projet 1'),
    Project(title: 'Projet n° 2', desc: 'Description du projet 2'),
    Project(title: 'Projet n° 3', desc: 'Description du projet 3'),
  ];

  int _projectCounter = 4;

  void addProject() {
    setState(() {
      _projects.add(Project(
        title: 'Projet n° $_projectCounter',
        desc: 'Description du projet $_projectCounter',
      ));
      _projectCounter++;
    });
  }

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

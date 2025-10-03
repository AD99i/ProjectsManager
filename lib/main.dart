import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'model/Project.dart';
import 'ContributionPage.dart';
import 'ProjectsPage.dart';
import 'ProjectDetailsPage.dart';
import 'providers/ProjectProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProjectProvider(),
      child: ProjectManagerApp(),
    )
  );
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        //Project? project = state.extra as Project;
        return HomeScreen();
      },
      routes: [
        GoRoute(
            path: 'details',
            builder: (context, state) {
              Project project = state.extra as Project;
              return ProjectDetailsPage(project: project);
            }),
        GoRoute(
            path: 'update',
            builder: (context, state) {
              Project project = state.extra as Project;
              return EditProject(context, project: project,);
            })
      ],
    ),
  ],
);

class ProjectManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return MaterialApp.router(
      title: 'Gestion de Projets',
      routerConfig: _router,
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


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final projectProvider = Provider.of<ProjectProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Mes Projets" : "Contribuer"),
        centerTitle: true,
        leading: const Icon(Icons.rocket_launch_rounded),
      ),
      body: _selectedIndex == 0
          ? ProjectsPage()
          : ContributionPage(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        tooltip: 'Adding Project',
        onPressed: () {
          setState(() {
            int num = projectProvider.projects.length + 1;
            projectProvider.addProject(Project(title: 'New Projet $num', desc: 'nouveau projet'));
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

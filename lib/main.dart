import 'package:flutter/material.dart';
import 'package:tp/models/Project.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        cardTheme: CardThemeData(
          color: Colors.black87,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Color(0xffeceaea),
        textTheme: TextTheme(
          titleMedium: TextStyle(fontSize: 32, color: Colors.white),
          bodySmall: TextStyle(fontSize: 12, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 18, color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo,
          elevation: 2,
          shadowColor: Colors.black,

        ),

      ),
      home: const MyHomePage(title: 'Mes Projets'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title,style: Theme.of(context).textTheme.titleMedium,)),
        leading: Icon(Icons.rocket_launch,color: Colors.white,),

      ),
      body: ListsWithCards(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Badge(child: Icon(Icons.work)),
            label: 'Projets',

          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.add_circle)),
            label: 'Contribuer',

          ),
        ],
      backgroundColor: Colors.black,
      ),
    );
  }
}

class ListsWithCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var project1 = Project("Projet 1", "Description du projet 1");
    var project2 = Project("Projet 2", "Description du projet 2");
    var project3 = Project("Projet 3", "Description du projet 3");

    List<Project> listData = [project1, project2, project3];

    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(listData[index].title,style: Theme.of(context).textTheme.bodyMedium,),
            subtitle: Text(listData[index].desc,style: Theme.of(context).textTheme.bodySmall),
            leading: Icon(Icons.work_outline_sharp,color: Theme.of(context).primaryColor,),
            trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white),

          ),
        );
      },
    );
  }
}




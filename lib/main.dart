import 'package:flutter/material.dart';

import 'package:tm_countries/views/accueil/accueil.dart';
import 'package:tm_countries/views/components/page_header.dart';

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
        primarySwatch: Colors.blue,
        fontFamily: 'Spartan',
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color.fromARGB(255, 151, 140, 140),
            letterSpacing: 2.5,
            fontSize: 50,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _currentIndex = 0;
  final List<Widget> _widgetPages = <Widget>[
    const PageAccueil(),
    // const PageHeader(
    //     title: "Accueil", iconData: Icons.home, iconColor: Colors.blue),
    const PageHeader(
        title: "Favoris", iconData: Icons.favorite, iconColor: Colors.orange),
    const PageHeader(
        title: "About", iconData: Icons.question_mark, iconColor: Colors.green),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _widgetPages.elementAt(_currentIndex),
        ],
      ),
      bottomNavigationBar: _navigationBar(context),
    );
  }

  Widget _navigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoris',
          backgroundColor: Colors.orange,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_mark),
          label: 'About',
          backgroundColor: Colors.green,
        ),
      ],
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
    );
  }

  
}



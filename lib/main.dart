import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm_countries/cubit/countries_cubit.dart';
import 'package:tm_countries/cubit/favourites_cubit.dart';
import 'package:tm_countries/utils/colors.dart';

import 'package:tm_countries/views/accueil/accueil.dart';
import 'package:tm_countries/views/components/page_header.dart';
import 'package:tm_countries/views/favourites/favourite_page.dart';

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
            color: CustomColors.lightGrey,
            letterSpacing: 2.5,
            fontSize: 50,
            fontWeight: FontWeight.w600,
          ),
          headline2: TextStyle(
            color: CustomColors.grey,
            letterSpacing: 2.5,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
          headline3: TextStyle(
            color: CustomColors.darkGrey,
            letterSpacing: 2,
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
          headline4: TextStyle(
            color: CustomColors.darkGrey,
            letterSpacing: 2,
            fontSize: 21,
            fontWeight: FontWeight.w300,
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
    const FavouritesPage(),
    const PageHeader(
        title: "About", iconData: Icons.question_mark, iconColor: Colors.green),
    const PageHeader(
        title: "My Country", iconData: Icons.location_on, iconColor: Colors.teal),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers : [
        BlocProvider(create: (context) => CountriesCubit()..fetchAllCountries()),
        BlocProvider(create: (context) => FavouritesCubit()),
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _widgetPages.elementAt(_currentIndex),
            ],
          ),
        ),
        bottomNavigationBar: _navigationBar(context),
      ),
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
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'My Country',
          backgroundColor: Colors.teal,
        ),
      ],
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
    );
  }

  
}



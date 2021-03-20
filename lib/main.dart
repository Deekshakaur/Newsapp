import 'package:flutter/material.dart';
import 'package:newsapp/Screens/Profile/profile.dart';
import 'package:newsapp/Screens/Search/search.dart';
import 'package:newsapp/data.dart';
import 'package:provider/provider.dart';
import 'Screens/Home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Article(),
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData.light(),
        initialRoute: MainPage.id,
        routes: {
          MainPage.id: (context) => MainPage(),
          App.id: (context) => App(),
          Search.id: (context) => Search(),
          Profile.id: (context) => Profile(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  static const id = '123';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List items = [
    App(),
    Search(),
  ];

  void onTapIcon(int index) {
    setState(() {
      _currentIndex = index;
    });
  } //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _currentIndex,
        onTap: onTapIcon,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: 'Search'),
        ],
      ),
    );
  }
}

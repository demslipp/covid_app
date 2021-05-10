import 'package:covid_app/User.dart';
import 'package:covid_app/news/news_homepage.dart';
import 'package:covid_app/profile_tab.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class TabPage extends StatefulWidget {
  TabPage({this.user});

  User user;

  @override
  State<StatefulWidget> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  static List tabNames = ['Новости', 'QR коды', 'Поддержка', 'Профиль'];
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _titleOptions = <Widget>[
    Text('${tabNames[0]}'),
    Text(
      '${tabNames[1]}',
    ),
    Text(
      '${tabNames[2]}',
    ),
    Text('${tabNames[3]}'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _titleOptions.elementAt(_selectedIndex),
      ),
      body: Center(
        child: <Widget>[
          HomePage(),
          HomeScreen(),
          Text(
            'Сhat',
            style: optionStyle,
          ),
          ProfileTab(user: widget.user)
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: tabNames[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: tabNames[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: tabNames[2],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: tabNames[3],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

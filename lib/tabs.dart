import 'package:covid_app/dialog/new_dialog_page.dart';
import 'package:covid_app/local_user.dart';
import 'package:covid_app/news/news_homepage.dart';
import 'package:covid_app/profile_tab.dart';
import 'package:covid_app/restrictions.dart';
import 'package:flutter/material.dart';

import 'qr_home.dart';

class TabPage extends StatefulWidget {
  TabPage({this.user, this.logoutCallback});

  LocalUser user;
  VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  static List tabNames = [
    'Новости',
    'QR коды',
    'Доступность',
    'Поддержка',
    'Профиль'
  ];
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
    Text('${tabNames[4]}'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: <Widget>[
          HomePage(),
          HomeScreen(),
          RestrictionsTab(),
          NewDialogPage(),
          ProfileTab(logoutCallback: widget.logoutCallback)
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
            icon: Icon(Icons.airplanemode_active),
            label: tabNames[2],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: tabNames[3],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: tabNames[4],
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

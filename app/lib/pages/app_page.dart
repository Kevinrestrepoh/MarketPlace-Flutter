import 'package:app/pages/home_page.dart';
import 'package:app/pages/profile_page.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPage();
}

class _AppPage extends State<AppPage> {
  int _selectedPage = 0;

  void _setPage(int index){
    setState(() {
      _selectedPage = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    Center(child: Text('Settings'),)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _pages[_selectedPage]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _setPage,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueGrey[900],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ]
      ),
    );
  }
}
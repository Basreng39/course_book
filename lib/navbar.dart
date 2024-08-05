import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'categoriesCourse.dart'; 
import 'mycourse.dart';         
import 'myprofil.dart';         

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  // List of pages
  static const List<Widget> _pages = <Widget>[
    Dashboard.new(),
    CategoriesCoursePage(categoryId: 1,),
    MyCoursesPage(),
    MyProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 43, 47),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 43, 43, 47),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'My Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xAD40B59F),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Navbar(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0, // Ensure the text scale factor is constant
          ),
          child: child!,
        );
      },
    ),
  );
}

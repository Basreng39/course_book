import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'categoriesCourse.dart';
import 'mybooking.dart';
import 'myprofil.dart';
import 'myclasses.dart';

class Navbar extends StatefulWidget {
  final int selectedIndex;

  Navbar(
      {this.selectedIndex =
          0}); // Tambahkan parameter selectedIndex dengan default 0

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late int _selectedIndex;
  int? _selectedCategoryId; // Variable to store the selected category ID

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget
        .selectedIndex; // Inisialisasi _selectedIndex dengan nilai dari widget
  }

  // List of pages
  List<Widget> _pages() => <Widget>[
        Dashboard(
          onCategorySelected: (categoryId) {
            setState(() {
              _selectedIndex = 1; // Navigate to CategoriesCoursePage
              _selectedCategoryId = categoryId; // Set the selected category ID
            });
          },
        ),
        CategoriesCoursePage(categoryId: _selectedCategoryId),
        MyBookingPage(),
        MyClassesPage(),
        MyProfile(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        // Reset the category filter when navigating directly to CategoriesCoursePage
        _selectedCategoryId = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 43, 47),
      body: _pages()[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 43, 43, 47),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school), // Ikon untuk Course
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'My Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'My Classes',
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

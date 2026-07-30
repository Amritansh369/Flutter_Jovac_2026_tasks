import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'tabs/home_tab.dart';
import 'tabs/attendance_tab.dart';
import 'tabs/assignments_tab.dart';
import 'tabs/profile_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeTab(),
    AttendanceTab(),
    AssignmentsTab(),
    ProfileTab(),
  ];

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6C3FC5),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event_available), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Assignments'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/assignment_details_screen.dart';

void main() {
  runApp(const AssignmentPortalApp());
}

const kPrimaryColor = Color(0xFF4527A0);
const kBackgroundColor = Color(0xFFF5F5F7);

class AssignmentPortalApp extends StatelessWidget {
  const AssignmentPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Assignment Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: kPrimaryColor,
            side: const BorderSide(color: kPrimaryColor),
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const AssignmentDetailsScreen(),
    );
  }
}

/// Shared model passed between screens as the flow progresses.
class AssignmentSubmission {
  String studentName;
  String assignment;
  String subject;
  String faculty;
  String lastDate;
  int totalMarks;

  DateTime? submissionDate;
  TimeOfDay? submissionTime;
  String? fileName;
  double? fileSizeMb;

  double? rating;

  AssignmentSubmission({
    this.studentName = 'Rahul Sharma',
    this.assignment = 'Flutter UI Widgets',
    this.subject = 'Mobile Application Dev.',
    this.faculty = 'Mr. Pankaj Kapoor',
    this.lastDate = '30 July 2026',
    this.totalMarks = 100,
    this.submissionDate,
    this.submissionTime,
    this.fileName,
    this.fileSizeMb,
    this.rating,
  });

  String get formattedDate {
    if (submissionDate == null) return '';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${submissionDate!.day} ${months[submissionDate!.month - 1]} ${submissionDate!.year}';
  }

  String get formattedTime {
    if (submissionTime == null) return '';
    final hour = submissionTime!.hourOfPeriod == 0
        ? 12
        : submissionTime!.hourOfPeriod;
    final minute = submissionTime!.minute.toString().padLeft(2, '0');
    final period = submissionTime!.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }
}

/// Reusable card wrapper used across screens.
class SectionCard extends StatelessWidget {
  final Widget child;
  const SectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: EdgeInsets.zero,
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}

/// Reusable bottom navigation bar shown on top-level screens.
class PortalBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const PortalBottomNav(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined),
            label: 'My Submissions'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

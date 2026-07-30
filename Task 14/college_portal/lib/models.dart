import 'package:flutter/material.dart';

class CourseItem {
  final String title;
  final String subtitle;
  final String instructor;
  final IconData icon;
  final Color color;

  const CourseItem({
    required this.title,
    required this.subtitle,
    required this.instructor,
    required this.icon,
    required this.color,
  });
}

class NoticeItem {
  final String title;
  final String date;
  final String description;
  final IconData icon;
  final Color color;

  const NoticeItem({
    required this.title,
    required this.date,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class AssignmentItem {
  final String title;
  final String subtitle;
  final String dueDate;
  final String dueLabel;
  final Color dueColor;
  final IconData icon;
  final Color color;

  const AssignmentItem({
    required this.title,
    required this.subtitle,
    required this.dueDate,
    required this.dueLabel,
    required this.dueColor,
    required this.icon,
    required this.color,
  });
}

// ---- Sample / mock data used across the app ----

const List<CourseItem> sampleCourses = [
  CourseItem(
    title: 'Flutter Development',
    subtitle: 'Learn Flutter from Basics',
    instructor: 'Instructor: Mr. Sharma',
    icon: Icons.smartphone,
    color: Color(0xFF2196F3),
  ),
  CourseItem(
    title: 'Java Programming',
    subtitle: 'Core Java and OOPs',
    instructor: 'Instructor: Ms. Joshi',
    icon: Icons.coffee,
    color: Color(0xFF43A047),
  ),
  CourseItem(
    title: 'Python Programming',
    subtitle: 'Python for Beginners',
    instructor: 'Instructor: Mr. Verma',
    icon: Icons.code,
    color: Color(0xFFFB8C00),
  ),
];

const List<NoticeItem> sampleNotices = [
  NoticeItem(
    title: 'Holiday Tomorrow',
    date: '20 May 2025',
    description: 'College will remain closed tomorrow on account of Local Holiday.',
    icon: Icons.campaign,
    color: Color(0xFFE53935),
  ),
  NoticeItem(
    title: 'Flutter Assignment Submission',
    date: '18 May 2025',
    description: 'Submit your Flutter Assignment-13 before 22 May 2025.',
    icon: Icons.assignment,
    color: Color(0xFF1E88E5),
  ),
  NoticeItem(
    title: 'Mid Semester Exam',
    date: '15 May 2025',
    description: 'Mid Semester Exams will start from 1st June 2025.',
    icon: Icons.calendar_month,
    color: Color(0xFFFB8C00),
  ),
];

const List<AssignmentItem> sampleAssignments = [
  AssignmentItem(
    title: 'Flutter Assignment-13',
    subtitle: 'Build Navigation UI',
    dueDate: 'Due: 22 May 2025',
    dueLabel: 'Due Tomorrow',
    dueColor: Color(0xFFE53935),
    icon: Icons.smartphone,
    color: Color(0xFF2196F3),
  ),
  AssignmentItem(
    title: 'Java Assignment-7',
    subtitle: 'OOPs Concepts',
    dueDate: 'Due: 25 May 2025',
    dueLabel: '3 Days Left',
    dueColor: Color(0xFFFB8C00),
    icon: Icons.coffee,
    color: Color(0xFF43A047),
  ),
  AssignmentItem(
    title: 'Python Assignment-5',
    subtitle: 'Functions & Modules',
    dueDate: 'Due: 28 May 2025',
    dueLabel: '6 Days Left',
    dueColor: Color(0xFF43A047),
    icon: Icons.code,
    color: Color(0xFFFB8C00),
  ),
];

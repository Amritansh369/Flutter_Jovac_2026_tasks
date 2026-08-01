import 'package:flutter/material.dart';

void main() {
  runApp(const StudentPortalApp());
}

class StudentPortalApp extends StatelessWidget {
  const StudentPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Information Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4527A0),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4527A0)),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        useMaterial3: true,
      ),
      home: const StudentHomeScreen(),
    );
  }
}

/// ---------- MODELS ----------

class StudentDetails {
  final String name;
  final String email;
  final String mobile;
  final String rollNumber;
  final String collegeWebsite;

  const StudentDetails({
    required this.name,
    required this.email,
    required this.mobile,
    required this.rollNumber,
    required this.collegeWebsite,
  });
}

class SubjectMark {
  final String subject;
  final int maxMarks;
  final int obtained;

  const SubjectMark({
    required this.subject,
    required this.maxMarks,
    required this.obtained,
  });
}

/// ---------- HOME SCREEN ----------

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int _currentNavIndex = 0;

  final StudentDetails _student = const StudentDetails(
    name: 'Rahul Sharma',
    email: 'rahul@gmail.com',
    mobile: '+91 9876543210',
    rollNumber: 'CS202501',
    collegeWebsite: 'www.fluttercollege.com',
  );

  final List<SubjectMark> _marksheet = const [
    SubjectMark(subject: 'Mathematics', maxMarks: 100, obtained: 95),
    SubjectMark(subject: 'Science', maxMarks: 100, obtained: 90),
    SubjectMark(subject: 'English', maxMarks: 100, obtained: 88),
    SubjectMark(subject: 'Computer', maxMarks: 100, obtained: 98),
    SubjectMark(subject: 'Hindi', maxMarks: 100, obtained: 85),
  ];

  int get _totalObtained =>
      _marksheet.fold(0, (sum, item) => sum + item.obtained);
  int get _totalMax => _marksheet.fold(0, (sum, item) => sum + item.maxMarks);
  double get _percentage => (_totalObtained / _totalMax) * 100;

  String get _grade {
    if (_percentage >= 90) return 'A+';
    if (_percentage >= 80) return 'A';
    if (_percentage >= 70) return 'B';
    if (_percentage >= 60) return 'C';
    return 'D';
  }

  void _showStudentActions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StudentActionsSheet(
          onActionSelected: (action) {
            Navigator.pop(context);
            _handleAction(action);
          },
        );
      },
    );
  }

  void _handleAction(StudentAction action) {
    switch (action) {
      case StudentAction.sendEmail:
        _showSnackBar('Opening email to ${_student.email}...');
        break;
      case StudentAction.callStudent:
        _showSnackBar('Calling ${_student.mobile}...');
        break;
      case StudentAction.viewAddress:
        _showSnackBar('Opening address on map...');
        break;
      case StudentAction.shareProfile:
        _showSnackBar('Student Profile Shared Successfully!',
            showUndo: true);
        break;
      case StudentAction.downloadMarksheet:
        _showSnackBar('Downloading marksheet...');
        break;
      case StudentAction.close:
        break;
    }
  }

  void _showSnackBar(String message, {bool showUndo = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(12),
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        action: showUndo
            ? SnackBarAction(
                label: 'UNDO',
                textColor: Colors.white,
                onPressed: () {},
              )
            : null,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4527A0),
        elevation: 0,
        titleSpacing: 8,
        title: Row(
          children: const [
            Icon(Icons.school, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Student Information Portal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _StudentDetailsCard(student: _student),
            const SizedBox(height: 16),
            _MarksheetCard(
              marksheet: _marksheet,
              totalObtained: _totalObtained,
              totalMax: _totalMax,
              percentage: _percentage,
              grade: _grade,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _showStudentActions,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4527A0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.list),
                label: const Text(
                  'Show Student Actions',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        selectedItemColor: const Color(0xFF4527A0),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentNavIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

/// ---------- STUDENT DETAILS CARD ----------

class _StudentDetailsCard extends StatelessWidget {
  final StudentDetails student;

  const _StudentDetailsCard({required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(
              icon: Icons.account_circle,
              title: 'Student Details',
              color: Color(0xFF4527A0),
            ),
            const SizedBox(height: 12),
            _InfoRow(icon: Icons.person_outline, label: 'Student Name', value: student.name),
            _InfoRow(icon: Icons.email_outlined, label: 'Email', value: student.email, isLink: true),
            _InfoRow(icon: Icons.phone_outlined, label: 'Mobile', value: student.mobile),
            _InfoRow(icon: Icons.badge_outlined, label: 'Roll Number', value: student.rollNumber, isLink: true),
            _InfoRow(icon: Icons.public, label: 'College Website', value: student.collegeWebsite, isLink: true),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: color,
          child: Icon(icon, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLink;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLink = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: TextStyle(color: Colors.grey[700])),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isLink ? const Color(0xFF4527A0) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------- MARKSHEET CARD ----------

class _MarksheetCard extends StatelessWidget {
  final List<SubjectMark> marksheet;
  final int totalObtained;
  final int totalMax;
  final double percentage;
  final String grade;

  const _MarksheetCard({
    required this.marksheet,
    required this.totalObtained,
    required this.totalMax,
    required this.percentage,
    required this.grade,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(
              icon: Icons.grid_view,
              title: 'Student Marksheet',
              color: Color(0xFF4527A0),
            ),
            const SizedBox(height: 12),
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.grey.shade200),
              ),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.3),
                2: FlexColumnWidth(1.3),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  children: const [
                    _TableHeaderCell('Subject'),
                    _TableHeaderCell('Max Marks'),
                    _TableHeaderCell('Obtained'),
                  ],
                ),
                for (final mark in marksheet)
                  TableRow(
                    children: [
                      _TableCell(mark.subject, alignLeft: true),
                      _TableCell('${mark.maxMarks}'),
                      _TableCell(
                        '${mark.obtained}',
                        color: mark.obtained >= 90
                            ? const Color(0xFF2E7D32)
                            : Colors.black87,
                        bold: true,
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _SummaryStat(
                    icon: Icons.description_outlined,
                    label: '$totalObtained / $totalMax',
                    caption: 'Total Marks',
                  ),
                ),
                Expanded(
                  child: _SummaryStat(
                    icon: Icons.percent,
                    label: '${percentage.toStringAsFixed(1)}%',
                    caption: 'Percentage',
                  ),
                ),
                Expanded(
                  child: _SummaryStat(
                    icon: Icons.star_outline,
                    label: grade,
                    caption: 'Grade',
                    iconColor: Colors.amber,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  final String text;
  const _TableHeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool alignLeft;
  final bool bold;
  final Color color;

  const _TableCell(
    this.text, {
    this.alignLeft = false,
    this.bold = false,
    this.color = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Text(
        text,
        textAlign: alignLeft ? TextAlign.left : TextAlign.center,
        style: TextStyle(
          fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
          color: color,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String caption;
  final Color iconColor;

  const _SummaryStat({
    required this.icon,
    required this.label,
    required this.caption,
    this.iconColor = const Color(0xFF4527A0),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          caption,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

/// ---------- STUDENT ACTIONS BOTTOM SHEET ----------

enum StudentAction {
  sendEmail,
  callStudent,
  viewAddress,
  shareProfile,
  downloadMarksheet,
  close,
}

class StudentActionsSheet extends StatelessWidget {
  final ValueChanged<StudentAction> onActionSelected;

  const StudentActionsSheet({super.key, required this.onActionSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Student Actions',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4527A0),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _ActionTile(
              icon: Icons.email_outlined,
              label: 'Send Email',
              color: const Color(0xFF1565C0),
              onTap: () => onActionSelected(StudentAction.sendEmail),
            ),
            _ActionTile(
              icon: Icons.call_outlined,
              label: 'Call Student',
              color: const Color(0xFF2E7D32),
              onTap: () => onActionSelected(StudentAction.callStudent),
            ),
            _ActionTile(
              icon: Icons.location_on_outlined,
              label: 'View Address',
              color: const Color(0xFFEF6C00),
              onTap: () => onActionSelected(StudentAction.viewAddress),
            ),
            _ActionTile(
              icon: Icons.share_outlined,
              label: 'Share Profile',
              color: const Color(0xFF4527A0),
              onTap: () => onActionSelected(StudentAction.shareProfile),
            ),
            _ActionTile(
              icon: Icons.download_outlined,
              label: 'Download Marksheet',
              color: const Color(0xFF1565C0),
              onTap: () => onActionSelected(StudentAction.downloadMarksheet),
            ),
            _ActionTile(
              icon: Icons.cancel_outlined,
              label: 'Close',
              color: const Color(0xFFC62828),
              onTap: () => onActionSelected(StudentAction.close),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      onTap: onTap,
    );
  }
}
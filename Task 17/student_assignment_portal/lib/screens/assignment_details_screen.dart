import 'package:flutter/material.dart';
import '../main.dart';
import 'submit_assignment_screen.dart';
import 'assignment_guidelines_screen.dart';
import 'flutter_docs_screen.dart';
import 'tooltip_demo_screen.dart';

class AssignmentDetailsScreen extends StatefulWidget {
  const AssignmentDetailsScreen({super.key});

  @override
  State<AssignmentDetailsScreen> createState() =>
      _AssignmentDetailsScreenState();
}

class _AssignmentDetailsScreenState extends State<AssignmentDetailsScreen> {
  int _navIndex = 0;
  final AssignmentSubmission _submission = AssignmentSubmission();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Student Assignment Portal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: kPrimaryColor),
                child: Row(
                  children: const [
                    Icon(Icons.school, color: Colors.white, size: 32),
                    SizedBox(width: 10),
                    Text('Assignment Portal',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: const Text('Assignment Guidelines'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AssignmentGuidelinesScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.public),
                title: const Text('Flutter Documentation'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FlutterDocsScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.touch_app_outlined),
                title: const Text('Tooltip Demo'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TooltipDemoScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SectionCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school, size: 40, color: kPrimaryColor),
                      const SizedBox(width: 8),
                      Icon(Icons.assignment_turned_in,
                          size: 34, color: kPrimaryColor.withOpacity(0.7)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Assignment Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  const Divider(height: 24),
                  _DetailRow(label: 'Assignment', value: _submission.assignment),
                  _DetailRow(label: 'Subject', value: _submission.subject),
                  _DetailRow(label: 'Faculty', value: _submission.faculty),
                  _DetailRow(label: 'Last Date', value: _submission.lastDate),
                  _DetailRow(
                      label: 'Total Marks',
                      value: '${_submission.totalMarks}'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.file_upload_outlined),
              label: const Text('Submit Assignment'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SubmitAssignmentScreen(submission: _submission),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.menu_book_outlined),
              label: const Text('View Assignment Guidelines'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AssignmentGuidelinesScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: PortalBottomNav(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: TextStyle(color: Colors.grey[700])),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models.dart';
import '../widgets/app_drawer.dart';

class DashboardTabsScreen extends StatelessWidget {
  const DashboardTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('College Student Portal'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Courses'),
              Tab(text: 'Notices'),
              Tab(text: 'Results'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _CoursesTab(),
            _NoticesTab(),
            _ResultsTab(),
          ],
        ),
      ),
    );
  }
}

class _CoursesTab extends StatelessWidget {
  const _CoursesTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sampleCourses.length,
      itemBuilder: (context, index) {
        final course = sampleCourses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              backgroundColor: course.color.withOpacity(0.15),
              child: Icon(course.icon, color: course.color),
            ),
            title: Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('${course.subtitle}\n${course.instructor}'),
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}

class _NoticesTab extends StatelessWidget {
  const _NoticesTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sampleNotices.length,
      itemBuilder: (context, index) {
        final notice = sampleNotices[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              backgroundColor: notice.color.withOpacity(0.15),
              child: Icon(notice.icon, color: notice.color),
            ),
            title: Text(notice.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('${notice.date}\n${notice.description}'),
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}

class _ResultsTab extends StatelessWidget {
  const _ResultsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Results will appear here',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

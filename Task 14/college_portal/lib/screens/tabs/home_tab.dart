import 'package:flutter/material.dart';
import '../dashboard_tabs_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6C3FC5);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: purple,
          pinned: true,
          expandedHeight: 130,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            title: const Text(
              'Welcome Back 👋',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            background: Container(color: purple),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16,
                  child: Icon(Icons.person, color: purple, size: 20),
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pankaj Kapoor',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'B.Tech CSE | Roll No: 101',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Quick Links',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  children: [
                    _QuickLinkCard(
                      icon: Icons.menu_book,
                      label: 'Courses',
                      color: const Color(0xFFFFA000),
                      bgColor: const Color(0xFFFFF3D6),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DashboardTabsScreen()),
                      ),
                    ),
                    _QuickLinkCard(
                      icon: Icons.campaign,
                      label: 'Notices',
                      color: const Color(0xFF8E24AA),
                      bgColor: const Color(0xFFEEDCF5),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DashboardTabsScreen()),
                      ),
                    ),
                    _QuickLinkCard(
                      icon: Icons.assignment,
                      label: 'Assignments',
                      color: const Color(0xFF43A047),
                      bgColor: const Color(0xFFDDF3DD),
                      onTap: () {},
                    ),
                    _QuickLinkCard(
                      icon: Icons.bar_chart,
                      label: 'Results',
                      color: const Color(0xFFE53935),
                      bgColor: const Color(0xFFFBDCDC),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickLinkCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _QuickLinkCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

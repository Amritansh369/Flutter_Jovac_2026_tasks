import 'package:flutter/material.dart';
import '../screens/dashboard_tabs_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF6C3FC5);

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
            color: primaryPurple,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 34, color: primaryPurple),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Pankaj Kapoor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'B.Tech CSE',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      Text(
                        'Roll No: 101',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _DrawerTile(
            icon: Icons.dashboard,
            label: 'Dashboard',
            selected: true,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DashboardTabsScreen()),
              );
            },
          ),
          _DrawerTile(
            icon: Icons.person_outline,
            label: 'Profile',
            onTap: () => Navigator.pop(context),
          ),
          _DrawerTile(
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () => Navigator.pop(context),
          ),
          _DrawerTile(
            icon: Icons.help_outline,
            label: 'Help',
            onTap: () => Navigator.pop(context),
          ),
          _DrawerTile(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF6C3FC5);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: selected ? primaryPurple.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: selected ? primaryPurple : Colors.grey[700]),
        title: Text(
          label,
          style: TextStyle(
            color: selected ? primaryPurple : Colors.black87,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

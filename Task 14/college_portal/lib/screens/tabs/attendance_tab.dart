import 'package:flutter/material.dart';

class AttendanceTab extends StatelessWidget {
  const AttendanceTab({super.key});

  static const double percent = 0.85;
  static const int total = 120;
  static const int attended = 102;
  static const int remaining = 18;

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF1E88E5);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
          decoration: const BoxDecoration(
            color: blue,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            children: const [
              Text(
                'My Attendance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -50),
          child: Column(
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: CircularProgressIndicator(
                        value: percent,
                        strokeWidth: 12,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(blue),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          '85%',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text('Present', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _AttendanceStatRow(
                      icon: Icons.menu_book,
                      color: Colors.blue,
                      label: 'Total Classes',
                      value: '$total',
                    ),
                    const SizedBox(height: 12),
                    _AttendanceStatRow(
                      icon: Icons.check_circle,
                      color: Colors.green,
                      label: 'Classes Attended',
                      value: '$attended',
                    ),
                    const SizedBox(height: 12),
                    _AttendanceStatRow(
                      icon: Icons.event_busy,
                      color: Colors.red,
                      label: 'Classes Remaining',
                      value: '$remaining',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AttendanceStatRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _AttendanceStatRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

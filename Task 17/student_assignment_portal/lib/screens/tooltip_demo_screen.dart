import 'package:flutter/material.dart';
import '../main.dart';

class TooltipDemoScreen extends StatelessWidget {
  const TooltipDemoScreen({super.key});

  static const _items = [
    (icon: Icons.event_outlined, label: 'Select Date', tip: 'Choose the assignment submission date'),
    (icon: Icons.access_time, label: 'Select Time', tip: 'Choose the assignment submission time'),
    (icon: Icons.folder_outlined, label: 'Upload File', tip: 'Attach your assignment file'),
    (icon: Icons.star_border, label: 'Rate Experience', tip: 'Share feedback on the submission flow'),
    (icon: Icons.description_outlined, label: 'Open Guidelines', tip: 'Read the assignment guidelines'),
    (icon: Icons.public, label: 'Open Docs', tip: 'Open Flutter documentation'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tooltip Demo')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
                children: _items
                    .map((item) => _TooltipTile(
                          icon: item.icon,
                          label: item.label,
                          tip: item.tip,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              Text(
                'Long press on any icon\nto see tooltip',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TooltipTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String tip;
  const _TooltipTile(
      {required this.icon, required this.label, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tip,
      triggerMode: TooltipTriggerMode.longPress,
      preferBelow: false,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: kPrimaryColor, size: 26),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

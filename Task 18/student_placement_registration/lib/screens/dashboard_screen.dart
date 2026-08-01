import 'package:flutter/material.dart';
import '../main.dart';
import '../models/student_details.dart';
import '../services/preferences_service.dart';
import 'registration_form_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  StudentDetails? _details;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final details = await PreferencesService.load();
    setState(() {
      _details = details;
      _loading = false;
    });
  }

  Future<void> _editDetails() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationFormScreen(initialDetails: _details),
      ),
    );
    // In case the user comes back via the app back button rather than
    // being replaced, refresh to reflect any changes.
    _load();
  }

  Future<void> _deleteDetails() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Details?'),
        content: const Text(
            'This will permanently remove your saved placement registration.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await PreferencesService.delete();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RegistrationFormScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: kPrimaryColor)),
      );
    }

    if (_details == null) {
      // No data found (e.g. deleted in another session) — fall back to form.
      return const RegistrationFormScreen();
    }

    final d = _details!;

    return Scaffold(
      appBar: AppBar(title: const Text('Placement Dashboard')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFA5D6A7)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFF2E7D32),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${d.name}!',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const Text('Your placement details are saved.',
                            style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 1,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _DetailRow(
                        icon: Icons.person_outline,
                        label: 'Student Name',
                        value: d.name),
                    _DetailRow(
                        icon: Icons.badge_outlined,
                        label: 'Roll Number',
                        value: d.rollNumber),
                    _DetailRow(
                        icon: Icons.email_outlined, label: 'Email', value: d.email),
                    _DetailRow(
                        icon: Icons.phone_outlined,
                        label: 'Mobile Number',
                        value: d.mobileNumber),
                    _DetailRow(
                        icon: Icons.apartment_outlined,
                        label: 'Branch',
                        value: d.branch),
                    _DetailRow(
                        icon: Icons.bar_chart,
                        label: 'CGPA',
                        value: d.cgpa.toStringAsFixed(2)),
                    _DetailRow(
                      icon: Icons.emoji_events_outlined,
                      label: 'Placement Status',
                      value: d.interestedInPlacement ? 'Interested' : 'Not Interested',
                      valueColor: d.interestedInPlacement
                          ? const Color(0xFF2E7D32)
                          : Colors.grey,
                      valueIcon: d.interestedInPlacement
                          ? Icons.check_circle
                          : Icons.remove_circle_outline,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit_outlined),
              label: const Text('EDIT DETAILS'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _editDetails,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.delete_outline),
              label: const Text('DELETE DETAILS'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC62828),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _deleteDetails,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final IconData? valueIcon;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: kPrimaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: TextStyle(color: Colors.grey[700])),
          ),
          if (valueIcon != null) ...[
            Icon(valueIcon, size: 16, color: valueColor),
            const SizedBox(width: 4),
          ],
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

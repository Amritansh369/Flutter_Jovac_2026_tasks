import 'package:flutter/material.dart';
import '../main.dart';
import '../models/student_details.dart';
import '../services/preferences_service.dart';
import 'dashboard_screen.dart';

const _branches = [
  'Computer Science',
  'Information Technology',
  'Electronics',
  'Mechanical',
  'Electrical',
  'Civil',
];

class RegistrationFormScreen extends StatefulWidget {
  /// When provided, the form opens pre-filled in "edit" mode with a back
  /// arrow. When null, this is the initial blank registration screen.
  final StudentDetails? initialDetails;

  const RegistrationFormScreen({super.key, this.initialDetails});

  @override
  State<RegistrationFormScreen> createState() =>
      _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _rollController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;
  late final TextEditingController _cgpaController;
  late String _branch;
  late bool _interested;

  bool _showSuccessBanner = false;
  bool _saving = false;

  bool get _isEdit => widget.initialDetails != null;

  @override
  void initState() {
    super.initState();
    final d = widget.initialDetails;
    _nameController = TextEditingController(text: d?.name ?? '');
    _rollController = TextEditingController(text: d?.rollNumber ?? '');
    _emailController = TextEditingController(text: d?.email ?? '');
    _mobileController = TextEditingController(text: d?.mobileNumber ?? '');
    _cgpaController =
        TextEditingController(text: d != null ? d.cgpa.toString() : '');
    _branch = d?.branch ?? _branches.first;
    _interested = d?.interestedInPlacement ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _cgpaController.dispose();
    super.dispose();
  }

  void _clearForm() {
    setState(() {
      _nameController.clear();
      _rollController.clear();
      _emailController.clear();
      _mobileController.clear();
      _cgpaController.clear();
      _branch = _branches.first;
      _interested = true;
      _showSuccessBanner = false;
    });
  }

  Future<void> _saveDetails() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final details = StudentDetails(
      name: _nameController.text.trim(),
      rollNumber: _rollController.text.trim(),
      email: _emailController.text.trim(),
      mobileNumber: _mobileController.text.trim(),
      branch: _branch,
      cgpa: double.tryParse(_cgpaController.text.trim()) ?? 0.0,
      interestedInPlacement: _interested,
    );

    await PreferencesService.save(details);

    if (!mounted) return;
    setState(() {
      _saving = false;
      _showSuccessBanner = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    if (_isEdit) {
      // Editing: go back to the dashboard, replacing this screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      // First-time registration: move forward to the dashboard.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: _isEdit,
        title: const Text('Student Placement Registration'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const _HeaderIllustration(),
              const SizedBox(height: 20),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Register Your Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _LabeledField(
                        icon: Icons.person_outline,
                        label: 'Student Name',
                        child: TextFormField(
                          controller: _nameController,
                          decoration:
                              const InputDecoration(hintText: 'Enter full name'),
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                      ),
                      _LabeledField(
                        icon: Icons.badge_outlined,
                        label: 'Roll Number',
                        child: TextFormField(
                          controller: _rollController,
                          decoration:
                              const InputDecoration(hintText: 'e.g. CS22045'),
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                      ),
                      _LabeledField(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              const InputDecoration(hintText: 'you@example.com'),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Required';
                            if (!v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                      ),
                      _LabeledField(
                        icon: Icons.phone_outlined,
                        label: 'Mobile Number',
                        child: TextFormField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          decoration:
                              const InputDecoration(hintText: '10-digit number'),
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                      ),
                      _LabeledField(
                        icon: Icons.apartment_outlined,
                        label: 'Branch',
                        child: DropdownButtonFormField<String>(
                          initialValue: _branch,
                          decoration: const InputDecoration(),
                          items: _branches
                              .map((b) =>
                                  DropdownMenuItem(value: b, child: Text(b)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _branch = v ?? _branches.first),
                        ),
                      ),
                      _LabeledField(
                        icon: Icons.bar_chart,
                        label: 'CGPA',
                        child: TextFormField(
                          controller: _cgpaController,
                          keyboardType:
                              const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(hintText: '0.0 - 10.0'),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Required';
                            final val = double.tryParse(v.trim());
                            if (val == null || val < 0 || val > 10) {
                              return 'Enter a value between 0-10';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.person_outline,
                              size: 18, color: Colors.grey[700]),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text('Interested in Placement',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                          Switch(
                            value: _interested,
                            onChanged: (v) => setState(() => _interested = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.save_outlined, size: 18),
                              label: Text(
                                  _saving ? 'Saving...' : 'SAVE DETAILS'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: _saving ? null : _saveDetails,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.delete_outline, size: 18),
                              label: const Text('CLEAR FORM'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: kPrimaryColor,
                                side: const BorderSide(color: kPrimaryColor),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: _clearForm,
                            ),
                          ),
                        ],
                      ),
                      if (_showSuccessBanner) ...[
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFA5D6A7)),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.check_circle,
                                  color: Color(0xFF2E7D32), size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Registration Saved Successfully!',
                                  style: TextStyle(
                                    color: Color(0xFF2E7D32),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderIllustration extends StatelessWidget {
  const _HeaderIllustration();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school, size: 56, color: kPrimaryColor),
          const SizedBox(width: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.assignment_outlined,
                  size: 48, color: kPrimaryColor.withOpacity(0.7)),
              const Positioned(
                bottom: 6,
                child: Icon(Icons.person, size: 18, color: Colors.blueGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;

  const _LabeledField(
      {required this.icon, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey[700]),
              const SizedBox(width: 8),
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

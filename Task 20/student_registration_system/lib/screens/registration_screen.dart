import 'package:flutter/material.dart';
import '../main.dart';
import '../database/database_helper.dart';
import '../models/student_model.dart';
import 'registration_success_screen.dart';
import 'student_list_screen.dart';

const _departments = [
  'Computer Science',
  'Information Technology',
  'Electronics',
  'Mechanical',
  'Electrical',
  'Civil',
];

const _semesters = [
  'Semester 1', 'Semester 2', 'Semester 3', 'Semester 4',
  'Semester 5', 'Semester 6', 'Semester 7', 'Semester 8',
];

class RegistrationScreen extends StatefulWidget {
  /// Non-null when editing an existing student (pre-fills the form and
  /// shows "Edit Student" / "Update Student" instead of the add flow).
  final Student? existingStudent;

  const RegistrationScreen({super.key, this.existingStudent});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _rollController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;
  late final TextEditingController _cgpaController;
  late String _department;
  late String _semester;

  bool _saving = false;

  bool get _isEdit => widget.existingStudent != null;

  @override
  void initState() {
    super.initState();
    final s = widget.existingStudent;
    _nameController = TextEditingController(text: s?.studentName ?? '');
    _rollController = TextEditingController(text: s?.rollNumber ?? '');
    _emailController = TextEditingController(text: s?.email ?? '');
    _mobileController = TextEditingController(text: s?.mobile ?? '');
    _cgpaController =
        TextEditingController(text: s != null ? s.cgpa.toString() : '');
    _department = s?.department ?? _departments.first;
    _semester = s?.semester ?? _semesters.first;
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
      _department = _departments.first;
      _semester = _semesters.first;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final student = Student(
      id: widget.existingStudent?.id,
      studentName: _nameController.text.trim(),
      rollNumber: _rollController.text.trim(),
      email: _emailController.text.trim(),
      mobile: _mobileController.text.trim(),
      department: _department,
      semester: _semester,
      cgpa: double.tryParse(_cgpaController.text.trim()) ?? 0.0,
    );

    if (_isEdit) {
      await DatabaseHelper.instance.updateStudent(student);
      if (!mounted) return;
      setState(() => _saving = false);
      // Return to the (updated) student list.
      Navigator.of(context).pop(true);
    } else {
      await DatabaseHelper.instance.insertStudent(student);
      if (!mounted) return;
      setState(() => _saving = false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => RegistrationSuccessScreen(student: student),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Student' : 'Student Registration'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
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
                  decoration: const InputDecoration(hintText: 'e.g. CS22045'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
              ),
              _LabeledField(
                icon: Icons.email_outlined,
                label: 'Email Address',
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
                label: 'Department',
                child: DropdownButtonFormField<String>(
                  initialValue: _department,
                  decoration: const InputDecoration(),
                  items: _departments
                      .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _department = v ?? _departments.first),
                ),
              ),
              _LabeledField(
                icon: Icons.calendar_view_month_outlined,
                label: 'Semester',
                child: DropdownButtonFormField<String>(
                  initialValue: _semester,
                  decoration: const InputDecoration(),
                  items: _semesters
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _semester = v ?? _semesters.first),
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
              const SizedBox(height: 20),
              if (_isEdit) ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save_outlined, size: 18),
                        label: Text(_saving ? 'Saving...' : 'Update Student'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _saving ? null : _submit,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.close, size: 18),
                        label: const Text('Cancel'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: kPrimaryColor,
                          side: const BorderSide(color: kPrimaryColor),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                ElevatedButton.icon(
                  icon: const Icon(Icons.how_to_reg_outlined, size: 18),
                  label: Text(_saving ? 'Registering...' : 'Register Student'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _saving ? null : _submit,
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  icon: const Icon(Icons.list_alt, size: 18),
                  label: const Text('View Students'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kPrimaryColor,
                    side: const BorderSide(color: kPrimaryColor),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const StudentListScreen()),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
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

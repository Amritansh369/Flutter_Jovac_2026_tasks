import 'package:flutter/material.dart';

class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _rollController = TextEditingController();
  final _cityController = TextEditingController();

  String? _selectedCourse;

  final List<String> _courses = const [
    'B.Tech Computer Science',
    'B.Tech Electronics',
    'B.Tech Mechanical',
    'B.Tech Civil',
    'BCA',
    'MCA',
  ];

  static const purple = Color(0xFF6C3FC5);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _rollController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _onReset() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _mobileController.clear();
    _rollController.clear();
    _cityController.clear();
    setState(() => _selectedCourse = null);
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _SuccessDialog(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          mobile: _mobileController.text.trim(),
          rollNo: _rollController.text.trim(),
          course: _selectedCourse ?? '',
          city: _cityController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Student Registration'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFFEDE7F6),
                  child: Icon(Icons.school, size: 42, color: purple),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Student Registration',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Please fill in the details to register',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 20),
                _FormField(
                  controller: _nameController,
                  label: 'Full Name *',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                _FormField(
                  controller: _emailController,
                  label: 'Email Address *',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    final emailRegex = RegExp(r'^[\w.\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                _FormField(
                  controller: _mobileController,
                  label: 'Mobile Number *',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter 10 digit mobile number';
                    }
                    if (value.trim().length != 10) {
                      return 'Please enter 10 digit mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                _FormField(
                  controller: _rollController,
                  label: 'Roll Number *',
                  icon: Icons.badge_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your roll number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  value: _selectedCourse,
                  decoration: InputDecoration(
                    labelText: 'Course *',
                    prefixIcon: const Icon(Icons.menu_book_outlined),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  items: _courses
                      .map((course) => DropdownMenuItem(value: course, child: Text(course)))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedCourse = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your course';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                _FormField(
                  controller: _cityController,
                  label: 'City *',
                  icon: Icons.location_on_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _onReset,
                        icon: const Icon(Icons.refresh, color: purple),
                        label: const Text('Reset', style: TextStyle(color: purple)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: purple),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _onSubmit,
                        icon: const Icon(Icons.send, size: 18, color: Colors.white),
                        label: const Text('Submit', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: purple,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.maxLength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _StudentRegistrationScreenState.purple, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  final String name;
  final String email;
  final String mobile;
  final String rollNo;
  final String course;
  final String city;

  const _SuccessDialog({
    required this.name,
    required this.email,
    required this.mobile,
    required this.rollNo,
    required this.course,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6C3FC5);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Color(0xFFDFF5E1),
              child: Icon(Icons.check, color: Color(0xFF2E7D32), size: 32),
            ),
            const SizedBox(height: 14),
            const Text(
              'Student Registered\nSuccessfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 18),
            _InfoRow(icon: Icons.person_outline, label: 'Name', value: name),
            _InfoRow(icon: Icons.email_outlined, label: 'Email', value: email),
            _InfoRow(icon: Icons.phone_outlined, label: 'Mobile', value: mobile),
            _InfoRow(icon: Icons.badge_outlined, label: 'Roll No', value: rollNo),
            _InfoRow(icon: Icons.menu_book_outlined, label: 'Course', value: course),
            _InfoRow(icon: Icons.location_on_outlined, label: 'City', value: city),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          SizedBox(
            width: 70,
            child: Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          ),
          const Text(':  ', style: TextStyle(fontSize: 13)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

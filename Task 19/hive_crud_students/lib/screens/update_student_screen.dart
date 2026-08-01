import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';
import '../models/student.dart';

class UpdateStudentScreen extends StatefulWidget {
  final Box<Student> studentBox;
  final int studentId;

  /// Null when this screen is being used to add a brand-new student;
  /// non-null when editing an existing one (fields are pre-filled).
  final Student? existingStudent;

  const UpdateStudentScreen({
    super.key,
    required this.studentBox,
    required this.studentId,
    required this.existingStudent,
  });

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _courseController;
  late final TextEditingController _ageController;

  bool get _isEdit => widget.existingStudent != null;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.existingStudent?.name ?? '');
    _courseController =
        TextEditingController(text: widget.existingStudent?.course ?? '');
    _ageController = TextEditingController(
        text: widget.existingStudent != null
            ? widget.existingStudent!.age.toString()
            : '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final student = Student(
      name: _nameController.text.trim(),
      course: _courseController.text.trim(),
      age: int.parse(_ageController.text.trim()),
    );

    await widget.studentBox.put(widget.studentId, student);

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Student')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const _FieldLabel('Name'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Student name'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 18),
              const _FieldLabel('Course'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _courseController,
                decoration: const InputDecoration(hintText: 'e.g. MBA'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 18),
              const _FieldLabel('Age'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'e.g. 23'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  final age = int.tryParse(v.trim());
                  if (age == null || age <= 0) return 'Enter a valid age';
                  return null;
                },
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _save,
                child: Text(_isEdit ? 'UPDATE STUDENT' : 'ADD STUDENT'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: kPrimaryColor,
                  side: const BorderSide(color: kPrimaryColor),
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCEL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13));
  }
}

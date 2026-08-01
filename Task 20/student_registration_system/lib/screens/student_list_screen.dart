import 'package:flutter/material.dart';
import '../main.dart';
import '../database/database_helper.dart';
import '../models/student_model.dart';
import 'registration_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student> _students = [];
  bool _loading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadStudents() async {
    setState(() => _loading = true);
    final students = await DatabaseHelper.instance.getAllStudents();
    setState(() {
      _students = students;
      _loading = false;
    });
  }

  Future<void> _onSearchChanged(String query) async {
    if (query.trim().isEmpty) {
      _loadStudents();
      return;
    }
    final results = await DatabaseHelper.instance.searchStudents(query.trim());
    setState(() => _students = results);
  }

  Future<void> _openEdit(Student student) async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationScreen(existingStudent: student),
      ),
    );
    if (updated == true) _loadStudents();
  }

  Future<void> _confirmDelete(Student student) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete Student'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Are you sure you want to delete this student record?'),
            const SizedBox(height: 12),
            Text('Name    : ${student.studentName}'),
            Text('Roll No : ${student.rollNumber}'),
          ],
        ),
        actions: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC62828),
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && student.id != null) {
      await DatabaseHelper.instance.deleteStudent(student.id!);
      _loadStudents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registered Students')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search by name or roll number...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Total Students: ${_students.length}',
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(color: kPrimaryColor))
                  : _students.isEmpty
                      ? Center(
                          child: Text(
                            'No students found.',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor:
                                  WidgetStateProperty.all(kPrimaryColor),
                              headingTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                              columns: const [
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Roll No')),
                                DataColumn(label: Text('Dept')),
                                DataColumn(label: Text('Sem')),
                                DataColumn(label: Text('CGPA')),
                                DataColumn(label: Text('Actions')),
                              ],
                              rows: _students.map((student) {
                                return DataRow(cells: [
                                  DataCell(Text(student.studentName)),
                                  DataCell(Text(student.rollNumber)),
                                  DataCell(Text(student.department)),
                                  DataCell(Text(student.semester
                                      .replaceAll('Semester ', 'Sem '))),
                                  DataCell(
                                      Text(student.cgpa.toStringAsFixed(2))),
                                  DataCell(Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: kPrimaryColor, size: 18),
                                        onPressed: () => _openEdit(student),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Color(0xFFE53935),
                                            size: 18),
                                        onPressed: () =>
                                            _confirmDelete(student),
                                      ),
                                    ],
                                  )),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
            ),
            if (_students.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Swipe left or right to see more columns',
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        onPressed: () async {
          final added = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (_) => const RegistrationScreen()),
          );
          if (added != false) _loadStudents();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

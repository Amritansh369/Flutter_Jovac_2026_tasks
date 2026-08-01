import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';
import '../models/student.dart';
import '../services/hive_service.dart';
import 'update_student_screen.dart';

class HiveScreen extends StatelessWidget {
  final Box<Student> studentBox;
  const HiveScreen({super.key, required this.studentBox});

  Future<void> _confirmDelete(BuildContext context, int id, String name) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student?'),
        content: Text('Remove $name from the list? This cannot be undone.'),
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
      await studentBox.delete(id);
    }
  }

  void _openAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UpdateStudentScreen(
          studentBox: studentBox,
          studentId: HiveService.nextId(studentBox),
          existingStudent: null,
        ),
      ),
    );
  }

  void _openEdit(BuildContext context, int id, Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UpdateStudentScreen(
          studentBox: studentBox,
          studentId: id,
          existingStudent: student,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Hive CRUD Students'),
      ),
      drawer: const Drawer(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: studentBox.listenable(),
          builder: (context, Box<Student> box, _) {
            final keys = box.keys.cast<int>().toList()..sort();

            if (keys.isEmpty) {
              return Center(
                child: Text(
                  'No students yet.\nTap + to add one.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: keys.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final id = keys[index];
                final student = box.get(id)!;
                return _StudentTile(
                  id: id,
                  student: student,
                  onEdit: () => _openEdit(context, id, student),
                  onDelete: () => _confirmDelete(context, id, student.name),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        onPressed: () => _openAdd(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _StudentTile extends StatelessWidget {
  final int id;
  final Student student;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _StudentTile({
    required this.id,
    required this.student,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${student.course} | Age : ${student.age} | ID : $id',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: kPrimaryColor, size: 20),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Color(0xFFE53935), size: 20),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

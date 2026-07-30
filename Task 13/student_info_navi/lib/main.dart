import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Information Navigator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1565C0),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
      onGenerateRoute: generateRoute,
    );
  }
}

/// ---------------- Screen 1: Home Screen ----------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Pankaj Kapoor');
  final TextEditingController _rollController =
      TextEditingController(text: '101');
  String _selectedCourse = 'Flutter';
  String? _updatedCourse;

  final List<String> _courses = ['Flutter', 'Java', 'Python', 'AI'];

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    super.dispose();
  }

  // Navigator.push -> pass data to Student Details Screen
  Future<void> _viewDetails() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailsScreen(
          name: _nameController.text,
          rollNo: _rollController.text,
          course: _selectedCourse,
        ),
      ),
    );

    // result comes back from Student Details Screen (after Edit Course flow)
    if (result != null && result is String) {
      setState(() {
        _selectedCourse = result;
        _updatedCourse = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        elevation: 0,
        centerTitle: true,
        title: const Text('Student Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            const Icon(Icons.school, size: 90, color: Color(0xFF1565C0)),
            const SizedBox(height: 24),
            const Text('Student Name',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: _nameController,
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 16),
            const Text('Roll Number',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: _rollController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 16),
            const Text('Select Course',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _selectedCourse,
              decoration: _inputDecoration(),
              items: _courses
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedCourse = val!),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _viewDetails,
              icon: const Icon(Icons.remove_red_eye),
              label: const Text('View Details'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            if (_updatedCourse != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text('Updated Course :',
                        style: TextStyle(color: Colors.black54)),
                    Text(
                      _updatedCourse!,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black12),
      ),
    );
  }
}

/// ---------------- Screen 2: Student Details Screen ----------------
class StudentDetailsScreen extends StatefulWidget {
  final String name;
  final String rollNo;
  final String course;

  const StudentDetailsScreen({
    super.key,
    required this.name,
    required this.rollNo,
    required this.course,
  });

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  late String _currentCourse;

  @override
  void initState() {
    super.initState();
    _currentCourse = widget.course;
  }

  // Navigator.pushNamed -> pass current course to Edit Course Screen
  Future<void> _editCourse() async {
    final result = await Navigator.pushNamed(
      context,
      '/editCourse',
      arguments: _currentCourse,
    );

    if (result != null && result is String) {
      setState(() => _currentCourse = result);
    }
  }

  // Navigator.pop -> return selected course back to Home Screen
  void _goBack() {
    Navigator.pop(context, _currentCourse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        title: const Text('Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Student Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _detailRow(Icons.person, const Color(0xFFE3F2FD),
                      Colors.blue, 'Name', widget.name),
                  const Divider(height: 28),
                  _detailRow(Icons.badge, const Color(0xFFEDE7F6),
                      Colors.deepPurple, 'Roll No', widget.rollNo),
                  const Divider(height: 28),
                  _detailRow(Icons.menu_book, const Color(0xFFE8F5E9),
                      Colors.green, 'Course', _currentCourse),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _editCourse,
              icon: const Icon(Icons.edit),
              label: const Text('Edit Course'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF512DA8),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _goBack,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF2E7D32),
                side: const BorderSide(color: Color(0xFF2E7D32)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(
      IconData icon, Color bg, Color fg, String label, String value) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: fg, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
            Text(value,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}

/// ---------------- Screen 3: Edit Course Screen ----------------
class EditCourseScreen extends StatefulWidget {
  final String currentCourse;

  const EditCourseScreen({super.key, required this.currentCourse});

  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  late String _selectedCourse;
  final List<String> _courses = ['Flutter', 'Java', 'Python', 'AI'];

  @override
  void initState() {
    super.initState();
    _selectedCourse = widget.currentCourse;
  }

  // Navigator.pop with data -> return selected course to Student Details Screen
  void _saveChanges() {
    Navigator.pop(context, _selectedCourse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEF6C00),
        elevation: 0,
        title: const Text('Edit Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select New Course',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEF6C00),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: _courses.map((course) {
                  return RadioListTile<String>(
                    value: course,
                    groupValue: _selectedCourse,
                    activeColor: const Color(0xFFEF6C00),
                    title: Text(course),
                    onChanged: (val) => setState(() => _selectedCourse = val!),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.check),
              label: const Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF6C00),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- Named route generator (for pushNamed) ----------------
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/editCourse':
      final currentCourse = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => EditCourseScreen(currentCourse: currentCourse),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
  }
}
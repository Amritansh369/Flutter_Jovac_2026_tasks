import 'package:hive_flutter/hive_flutter.dart';
import '../models/student.dart';

/// Wraps Hive setup and gives the rest of the app a single opened box
/// to read/write Student records against.
class HiveService {
  static const String boxName = 'students';

  static Future<Box<Student>> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(StudentAdapter());
    final box = await Hive.openBox<Student>(boxName);

    if (box.isEmpty) {
      await _seed(box);
    }
    return box;
  }

  static Future<void> _seed(Box<Student> box) async {
    await box.put(1, Student(name: 'Rahul', course: 'BCA', age: 20));
    await box.put(2, Student(name: 'Aman', course: 'B.Tech', age: 21));
    await box.put(3, Student(name: 'Priya', course: 'MBA', age: 23));
    await box.put(4, Student(name: 'Neha', course: 'MCA', age: 22));
    await box.put(5, Student(name: 'Rohit', course: 'BBA', age: 19));
  }

  /// Next integer key to use when adding a new student, so IDs keep
  /// counting up (6, 7, 8...) even after earlier records are deleted.
  static int nextId(Box<Student> box) {
    final keys = box.keys.cast<int>();
    if (keys.isEmpty) return 1;
    return keys.reduce((a, b) => a > b ? a : b) + 1;
  }
}

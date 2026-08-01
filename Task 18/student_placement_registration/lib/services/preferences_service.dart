import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student_details.dart';

/// Wraps SharedPreferences to save, load, and delete the student's
/// placement registration details as a single JSON-encoded string.
class PreferencesService {
  static const _key = 'student_placement_details';

  static Future<void> save(StudentDetails details) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(details.toMap()));
  }

  static Future<StudentDetails?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return null;
    return StudentDetails.fromMap(jsonDecode(raw) as Map<String, dynamic>);
  }

  static Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static Future<bool> hasSavedDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_key);
  }
}

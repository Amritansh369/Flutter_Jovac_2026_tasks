import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/student.dart';
import 'services/hive_service.dart';
import 'screens/hive_screen.dart';

const kPrimaryColor = Color(0xFF4527A0);
const kBackgroundColor = Color(0xFFF5F5F7);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final box = await HiveService.init();
  runApp(HiveCrudApp(studentBox: box));
}

class HiveCrudApp extends StatelessWidget {
  final Box<Student> studentBox;
  const HiveCrudApp({super.key, required this.studentBox});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive CRUD Students',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
          ),
        ),
      ),
      home: HiveScreen(studentBox: studentBox),
    );
  }
}

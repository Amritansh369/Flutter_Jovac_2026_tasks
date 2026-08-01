import 'package:flutter/material.dart';
import 'services/preferences_service.dart';
import 'screens/registration_form_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const PlacementRegistrationApp());
}

const kPrimaryColor = Color(0xFF4527A0);
const kBackgroundColor = Color(0xFFF5F5F7);

class PlacementRegistrationApp extends StatelessWidget {
  const PlacementRegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Placement Registration',
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
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
              (states) => Colors.white),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return kPrimaryColor;
            return Colors.grey.shade400;
          }),
        ),
      ),
      home: const StartupRouter(),
    );
  }
}

/// Decides whether to open the Dashboard (details already saved) or the
/// blank Registration Form, based on what's in SharedPreferences.
class StartupRouter extends StatefulWidget {
  const StartupRouter({super.key});

  @override
  State<StartupRouter> createState() => _StartupRouterState();
}

class _StartupRouterState extends State<StartupRouter> {
  bool _loading = true;
  bool _hasDetails = false;

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final hasDetails = await PreferencesService.hasSavedDetails();
    setState(() {
      _hasDetails = hasDetails;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: kPrimaryColor)),
      );
    }
    return _hasDetails ? const DashboardScreen() : const RegistrationFormScreen();
  }
}

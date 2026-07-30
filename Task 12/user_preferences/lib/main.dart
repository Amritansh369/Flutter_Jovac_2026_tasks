import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Preferences',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6C4DF6),
        fontFamily: 'Roboto',
      ),
      home: const UserPreferencesScreen(),
    );
  }
}

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({super.key});

  @override
  State<UserPreferencesScreen> createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  bool _notificationsEnabled = true;
  bool _isDarkMode = true;
  String _selectedGender = 'Female';
  bool _termsAccepted = true;
  double _fontSize = 20;
  String _selectedInterest = 'Flutter';
  bool _showSavedBanner = true;

  static const Color primaryPurple = Color(0xFF6C4DF6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryPurple,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text(
          'User Preferences',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationsTile(),
            const Divider(height: 1),
            _buildThemeTile(),
            const Divider(height: 1),
            _buildGenderTile(),
            const Divider(height: 1),
            _buildTermsTile(),
            const Divider(height: 1),
            _buildFontSizeTile(),
            const Divider(height: 1),
            _buildInterestsTile(),
            const Divider(height: 1),
            _buildQuickActionsTile(),
            const Divider(height: 1),
            _buildProfileCompletionTile(),
            const SizedBox(height: 8),
            _buildBottomButtons(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _sectionPadding({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: child,
    );
  }

  Widget _leadingIcon(IconData icon, Color bg, Color fg) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: fg, size: 20),
    );
  }

  Widget _statusText(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 48),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black54, fontSize: 13),
          children: [
            TextSpan(text: '$label : '),
            TextSpan(
              text: value,
              style: TextStyle(
                color: valueColor ?? primaryPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Notifications ----------------
  Widget _buildNotificationsTile() {
    return _sectionPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _leadingIcon(Icons.notifications, const Color(0xFFF3E9FF), primaryPurple),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Enable Notifications',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ),
              Switch(
                value: _notificationsEnabled,
                activeColor: primaryPurple,
                onChanged: (val) => setState(() => _notificationsEnabled = val),
              ),
            ],
          ),
          _statusText(
            'Notifications',
            _notificationsEnabled ? 'Enabled' : 'Disabled',
            valueColor: _notificationsEnabled ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  // ---------------- Theme ----------------
  Widget _buildThemeTile() {
    return _sectionPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _leadingIcon(Icons.palette, const Color(0xFFFFF3E0), Colors.orange),
              const SizedBox(width: 12),
              const Text('Choose Theme',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Row(
              children: [
                Expanded(child: _themeOption('Light', Icons.wb_sunny, !_isDarkMode)),
                const SizedBox(width: 8),
                Expanded(child: _themeOption('Dark', Icons.nightlight_round, _isDarkMode)),
              ],
            ),
          ),
          _statusText('Selected Mode', _isDarkMode ? 'Dark' : 'Light'),
        ],
      ),
    );
  }

  Widget _themeOption(String label, IconData icon, bool selected) {
    return GestureDetector(
      onTap: () => setState(() => _isDarkMode = label == 'Dark'),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: selected ? primaryPurple : const Color(0xFFF3EFFE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 18,
                color: selected ? Colors.amber[200] : Colors.orange),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Gender ----------------
  Widget _buildGenderTile() {
    return _sectionPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _leadingIcon(Icons.person, const Color(0xFFFFE9EF), Colors.pink),
              const SizedBox(width: 12),
              const Text('Select Gender',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
                _genderRadio('Male'),
                _genderRadio('Female'),
                _genderRadio('Other'),
              ],
            ),
          ),
          _statusText('Selected Gender', _selectedGender),
        ],
      ),
    );
  }

  Widget _genderRadio(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: label,
          groupValue: _selectedGender,
          activeColor: primaryPurple,
          onChanged: (val) => setState(() => _selectedGender = val!),
        ),
        Text(label),
        const SizedBox(width: 8),
      ],
    );
  }

  // ---------------- Terms ----------------
  Widget _buildTermsTile() {
    return _sectionPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: _termsAccepted,
                activeColor: Colors.green,
                onChanged: (val) => setState(() => _termsAccepted = val!),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                    children: [
                      const TextSpan(text: 'I accept the '),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          color: primaryPurple,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _statusText(
            'Status',
            _termsAccepted ? 'Accepted' : 'Not Accepted',
            valueColor: _termsAccepted ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  // ---------------- Font Size ----------------
  Widget _buildFontSizeTile() {
    return _sectionPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _leadingIcon(Icons.text_fields, const Color(0xFFE3F2FD), Colors.blue),
              const SizedBox(width: 12),
              const Text('Font Size (Sample Text)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 48),
                child: Text('10', style: TextStyle(color: Colors.black54)),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: primaryPurple,
                    thumbColor: primaryPurple,
                    inactiveTrackColor: const Color(0xFFE0E0E0),
                  ),
                  child: Slider(
                    value: _fontSize,
                    min: 10,
                    max: 30,
                    onChanged: (val) => setState(() => _fontSize = val),
                  ),
                ),
              ),
              const Text('30', style: TextStyle(color: Colors.black54)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black54, fontSize: 13),
                children: [
                  const TextSpan(text: 'Current Size : '),
                  TextSpan(
                    text: _fontSize.round().toString(),
                    style: TextStyle(color: primaryPurple, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Flutter is Awesome!',
                style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Interests ----------------
  Widget _buildInterestsTile() {
    final interests = ['Flutter', 'AI', 'Web Development', 'Game Development'];
    return _sectionPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _leadingIcon(Icons.favorite, const Color(0xFFF3E5F5), Colors.purple),
              const SizedBox(width: 12),
              const Text('Choose Your Interests (Select One)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: interests.map((interest) {
                final selected = interest == _selectedInterest;
                return GestureDetector(
                  onTap: () => setState(() => _selectedInterest = interest),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? primaryPurple : Colors.white,
                      border: Border.all(color: primaryPurple),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selected) ...[
                          const Icon(Icons.check, size: 14, color: Colors.white),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          interest,
                          style: TextStyle(
                            color: selected ? Colors.white : primaryPurple,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          _statusText('Selected Interest', _selectedInterest),
        ],
      ),
    );
  }

  // ---------------- Quick Actions ----------------
  Widget _buildQuickActionsTile() {
    return _sectionPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _leadingIcon(Icons.flash_on, const Color(0xFFFFF8E1), Colors.amber[800]!),
              const SizedBox(width: 12),
              const Text('Quick Actions',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _notificationsEnabled = true;
                    _isDarkMode = true;
                    _selectedGender = 'Female';
                    _termsAccepted = true;
                    _fontSize = 20;
                    _selectedInterest = 'Flutter';
                    _showSavedBanner = false;
                  });
                },
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Reset'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: Colors.black26),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => setState(() => _showSavedBanner = true),
                icon: const Icon(Icons.save, size: 16, color: Colors.white),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          if (_showSavedBanner)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Preferences Saved Successfully!',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _showSavedBanner = false),
                      child: const Text(
                        'DISMISS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ---------------- Profile Completion ----------------
  Widget _buildProfileCompletionTile() {
    return _sectionPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _leadingIcon(Icons.list_alt, const Color(0xFFE8EAF6), Colors.indigo),
              const SizedBox(width: 12),
              const Text('Profile Completion',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 8),
            child: Row(
              children: [
                _stepCircle('1', true),
                _stepLine(true),
                _stepCircle('2', true),
                _stepLine(false),
                _stepCircle('3', false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 8, top: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Personal Details',
                    style: TextStyle(fontSize: 11, color: primaryPurple)),
                Text('Preferences',
                    style: TextStyle(fontSize: 11, color: primaryPurple)),
                const Text('Finish',
                    style: TextStyle(fontSize: 11, color: Colors.black45)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepCircle(String number, bool active) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? primaryPurple : Colors.grey[400],
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _stepLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        color: active ? primaryPurple : Colors.grey[300],
      ),
    );
  }

  // ---------------- Bottom Buttons ----------------
  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryPurple,
                side: BorderSide(color: primaryPurple),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('CANCEL'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('CONTINUE'),
            ),
          ),
        ],
      ),
    );
  }
}
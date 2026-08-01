# Student Assignment Portal (Flutter)

Recreates the 10-screen flow: Assignment Details → Submit Assignment →
Date Picker → Time Picker → Uploading → Submission Successful →
Rate Experience → Assignment Guidelines → Flutter Documentation (WebView)
→ Tooltip Demo (accessible from the drawer menu on the home screen).

## Setup

1. Create a new Flutter project (or reuse an existing one):
   ```
   flutter create student_assignment_portal
   ```
2. Copy `lib/` and `pubspec.yaml` from this bundle into your project,
   overwriting the defaults.
3. Fetch packages:
   ```
   flutter pub get
   ```
4. Run:
   ```
   flutter run
   ```

## Notes

- **Date/Time pickers** use Flutter's built-in `showDatePicker` /
  `showTimePicker`, themed with the app's purple accent — these already
  closely match the mockup's calendar and clock dial UI.
- **Flutter Documentation** screen uses the `webview_flutter` package to
  load the real flutter.dev site in-app. If you don't need a real
  WebView, you can delete that dependency and swap in static content
  instead.
- **File upload** is simulated (no real file picker dependency) — tapping
  "Choose File" attaches a placeholder `assignment_flutter.pdf`. Swap in
  the `file_picker` package for real device file selection.
- **Uploading screen** simulates progress with a `Timer` and animates a
  circular progress indicator from 0–100%.

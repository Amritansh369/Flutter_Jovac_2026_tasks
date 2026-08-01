# Student Placement Registration (Flutter)

Recreates the 3-screen flow: Registration Form → Placement Dashboard →
Edit Details, with data persisted locally via `shared_preferences`.

## Setup

1. Create a new Flutter project:
   ```
   flutter create student_placement_registration
   ```
2. Copy `lib/` and `pubspec.yaml` from this bundle into it, overwriting
   the defaults.
3. Fetch packages:
   ```
   flutter pub get
   ```
4. Run:
   ```
   flutter run
   ```

## How it works

- **Registration Form** — validated form (name, roll number, email,
  mobile, branch dropdown, CGPA, "Interested in Placement" switch).
  "SAVE DETAILS" writes the data to `SharedPreferences` as JSON and
  shows the green success banner before moving to the Dashboard.
  "CLEAR FORM" only resets the on-screen fields, it doesn't delete
  anything already saved.
- **Placement Dashboard** — reads the saved details back out of
  `SharedPreferences` and displays them, with a welcome banner and a
  "Placement Status" row (Interested / Not Interested).
- **Edit Details** — same form widget as Registration, opened with the
  saved details pre-filled and a back arrow in the app bar. Saving
  overwrites the stored record and returns to the Dashboard.
- **Delete Details** — confirms with a dialog, then clears
  `SharedPreferences` and sends the user back to a blank Registration
  Form.
- **Persistence across restarts** — `main.dart` checks
  `SharedPreferences` on startup (`StartupRouter`) and opens the
  Dashboard directly if a record already exists, otherwise shows the
  blank Registration Form — matching the "data remains even after app
  is closed and reopened" behavior in the mockup.

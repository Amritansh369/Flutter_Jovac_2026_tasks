# Hive CRUD Students (Flutter)

Recreates the flow: Hive Screen (student list) → tap edit icon →
Update Student screen opens pre-filled → modify data → tap
"UPDATE STUDENT" → back on the Hive screen with the list updated —
all backed by a local Hive box, no server needed.

## Setup

1. Create a new Flutter project:
   ```
   flutter create hive_crud_students
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

No `build_runner` / code generation step is needed — `StudentAdapter`
in `lib/models/student.dart` is written by hand instead of generated,
so there's nothing extra to run before `flutter run`.

## How it works

- **`HiveService.init()`** initializes Hive, registers the
  `StudentAdapter`, opens the `students` box, and seeds it with the
  five students from the mockup (Rahul, Aman, Priya, Neha, Rohit) the
  first time the app runs. After that, whatever's in the box is what
  loads.
- **Hive Screen** uses `ValueListenableBuilder` on
  `studentBox.listenable()`, so the list re-renders automatically the
  instant a record is added, edited, or deleted — no manual
  `setState()` plumbing needed.
- **Edit** (pencil icon) opens `UpdateStudentScreen` pre-filled with
  that student's data; **Delete** (trash icon) asks for confirmation,
  then calls `box.delete(id)`.
- **Add** (the floating `+` button) opens the same
  `UpdateStudentScreen` in "add" mode (blank fields, button reads "ADD
  STUDENT"), assigned the next free integer ID so IDs keep counting up
  even after earlier students are deleted.
- **Data survives app restarts** automatically — Hive persists the box
  to disk, so reopening the app shows whatever was last saved.

# Student Registration System (Flutter + SQLite)

Recreates the full flow: Registration Form → Student Registered
(success) → View All Students → Edit Student → Delete Student, backed
by a local SQLite database via `sqflite`.

## Setup

1. Create a new Flutter project:
   ```
   flutter create student_registration_system
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
   (`sqflite` targets Android/iOS/macOS out of the box. For Windows/
   Linux/web you'd additionally need `sqflite_common_ffi` — not
   included here since the mockup's package panel only lists
   `sqflite` + `path`.)

## Project structure

```
lib/
├── database/
│   └── database_helper.dart   # singleton, opens the DB, all CRUD + search
├── models/
│   └── student_model.dart     # Student class + toMap/fromMap
├── screens/
│   ├── registration_screen.dart          # screens 1 & 4 (add / edit form)
│   ├── registration_success_screen.dart  # screen 2
│   └── student_list_screen.dart          # screens 3 & 5 (list, search, delete)
└── main.dart
```

## Database

Table `students`:

| Column       | Type    | Description            |
|--------------|---------|-------------------------|
| id           | INTEGER | Primary key, autoincrement |
| studentName  | TEXT    | Student Name            |
| rollNumber   | TEXT    | Roll Number              |
| email        | TEXT    | Email Address            |
| mobile       | TEXT    | Mobile Number            |
| department   | TEXT    | Department Name          |
| semester     | TEXT    | Semester                 |
| cgpa         | REAL    | CGPA                     |

## How it works

- **Registration Form** — validated inputs (name, roll number, email,
  mobile, department dropdown, semester dropdown, CGPA). "Register
  Student" inserts a row and pushes the success screen; "View
  Students" jumps straight to the list.
- **Student Registered** — green checkmark + a summary card of what
  was just saved, with "View All Students" and "Add Another Student".
- **View All Students** — loads all rows into a `DataTable`, with a
  live search box (`WHERE studentName LIKE ? OR rollNumber LIKE ?`)
  and a running "Total Students" count. The table scrolls
  horizontally on narrow screens.
- **Edit Student** — same form as registration, pre-filled, opened by
  tapping the pencil icon in a row; "Update Student" writes the
  change and returns to the (refreshed) list.
- **Delete Student** — the trash icon opens a confirmation dialog
  showing the student's name and roll number before the row is
  removed from the database.
- A floating `+` button on the list screen opens a blank Registration
  Form to add more students at any time.

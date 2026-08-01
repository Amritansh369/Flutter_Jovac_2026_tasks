/// Matches the `students` table:
/// id (PK, autoincrement) | studentName | rollNumber | email | mobile |
/// department | semester | cgpa
class Student {
  final int? id;
  final String studentName;
  final String rollNumber;
  final String email;
  final String mobile;
  final String department;
  final String semester;
  final double cgpa;

  const Student({
    this.id,
    required this.studentName,
    required this.rollNumber,
    required this.email,
    required this.mobile,
    required this.department,
    required this.semester,
    required this.cgpa,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'studentName': studentName,
      'rollNumber': rollNumber,
      'email': email,
      'mobile': mobile,
      'department': department,
      'semester': semester,
      'cgpa': cgpa,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int?,
      studentName: map['studentName'] as String,
      rollNumber: map['rollNumber'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      department: map['department'] as String,
      semester: map['semester'] as String,
      cgpa: (map['cgpa'] as num).toDouble(),
    );
  }

  Student copyWith({
    int? id,
    String? studentName,
    String? rollNumber,
    String? email,
    String? mobile,
    String? department,
    String? semester,
    double? cgpa,
  }) {
    return Student(
      id: id ?? this.id,
      studentName: studentName ?? this.studentName,
      rollNumber: rollNumber ?? this.rollNumber,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      cgpa: cgpa ?? this.cgpa,
    );
  }
}

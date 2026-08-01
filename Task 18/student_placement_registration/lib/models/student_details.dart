class StudentDetails {
  final String name;
  final String rollNumber;
  final String email;
  final String mobileNumber;
  final String branch;
  final double cgpa;
  final bool interestedInPlacement;

  const StudentDetails({
    required this.name,
    required this.rollNumber,
    required this.email,
    required this.mobileNumber,
    required this.branch,
    required this.cgpa,
    required this.interestedInPlacement,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rollNumber': rollNumber,
      'email': email,
      'mobileNumber': mobileNumber,
      'branch': branch,
      'cgpa': cgpa,
      'interestedInPlacement': interestedInPlacement,
    };
  }

  factory StudentDetails.fromMap(Map<String, dynamic> map) {
    return StudentDetails(
      name: map['name'] ?? '',
      rollNumber: map['rollNumber'] ?? '',
      email: map['email'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      branch: map['branch'] ?? 'Computer Science',
      cgpa: (map['cgpa'] as num?)?.toDouble() ?? 0.0,
      interestedInPlacement: map['interestedInPlacement'] ?? false,
    );
  }
}

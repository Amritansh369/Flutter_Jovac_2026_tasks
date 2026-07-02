void main() {
  String studentName = "John Doe";
  int rollNumber = 101;
  String course = "BCA";
  int semester = 3;

  int subject1 = 85;
  int subject2 = 78;
  int subject3 = 91;

  int totalMarks = subject1 + subject2 + subject3;
  double averageMarks = totalMarks / 3;
  double percentage = (totalMarks / 300) * 100;

  bool isPassed = percentage >= 40;

  subject1 += 5;

  totalMarks = subject1 + subject2 + subject3;
  averageMarks = totalMarks / 3;
  percentage = (totalMarks / 300) * 100;
  isPassed = percentage >= 40;

  print("==========================================");
  print("          STUDENT RESULT REPORT");
  print("==========================================");

  print("Student Name : $studentName");
  print("Roll Number  : $rollNumber");
  print("Course       : $course");
  print("Semester     : $semester");

  print("");

  print("Subject 1    : $subject1");
  print("Subject 2    : $subject2");
  print("Subject 3    : $subject3");

  print("");

  print("Total Marks  : $totalMarks");
  print("Average      : ${averageMarks.toStringAsFixed(2)}");
  print("Percentage   : ${percentage.toStringAsFixed(2)}%");
  print("Result       : ${isPassed ? "Pass" : "Fail"}");

  print("==========================================");
}
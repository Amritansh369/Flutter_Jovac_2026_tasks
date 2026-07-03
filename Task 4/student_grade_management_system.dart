void main() {
  // Step 1: List of Students
  List<String> students = ["Rahul", "Priya", "Aman", "Sneha", "Karan"];

  // Step 2: Map of Student Marks
  Map<String, int> marks = {
    "Rahul": 85,
    "Priya": 72,
    "Aman": 91,
    "Sneha": 65,
    "Karan": 38
  };
  int n=students.length;
  print("===== USING FOR LOOP =====");
  for(int i=0;i<n;i++){
    print(students[i]);
  }
  print("\n===== USING WHILE LOOP =====");
  int i=0;
  while(i<n){
    print(students[i]);
    i++;
  }
  print("\n===== USING DO-WHILE LOOP =====");
  int j=0;
  do{
    print(students[j]);
    j++;
  }while (j<n);
  print("\n===== USING FOR-IN LOOP =====");
  for(var stud in students){
    print(stud);
  }
  print("\n===== USING forEach LOOP =====");
  students.forEach((stud){
    print(stud);
  });

  String getGrade(int mark){
    if(mark>=90){
      return "A+";
    }else if(mark>=80){
      return "A";
    }else if(mark>=70){
      return "B";
    }else if(mark>=60){
      return "C";
    }else if(mark>=40){
      return "D";
    }else{
      return "Fail";
    }
  }

  String getPerformance(String grade){
    switch(grade){
      case "A+":
        return "Outstanding";
      case "A":
        return "Excellent";
      case "B":
        return "Very Good";
      case "C":
        return "Good";
      case "D":
        return "Needs Improvement";
      default:
        return "Failed";
    }
  }
  print("\n=========================================");
  print("        STUDENT GRADE REPORT");
  print("=========================================");
  for (var student in students) {
    int mark = marks[student]!;
    String grade = getGrade(mark);
    String performance = getPerformance(grade);

    print("\nStudent : $student");
    print("Marks   : $mark");
    print("Grade   : $grade");
    print("Remarks : $performance");
    print("-----------------------------------------");
  }
}
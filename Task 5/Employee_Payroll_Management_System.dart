import 'dart:io';

// Base Class
class Employee {
  String employeeId = "";
  String employeeName = "";
  String department = "";

  void displayEmployeeInfo() {
    print("Employee ID : $employeeId");
    print("Name        : $employeeName");
    print("Department  : $department");
  }
}

// Child Class
class Salary extends Employee {
  double basicSalary = 0;
  double hra = 0;
  double da = 0;
  double bonus = 0;

  double calculateGrossSalary() {
    return basicSalary + hra + da + bonus;
  }

  double calculateTax() {
    double gross = calculateGrossSalary();

    if (gross > 80000) {
      return gross * 0.20;
    } else if (gross > 50000) {
      return gross * 0.10;
    } else {
      return 0;
    }
  }

  double calculateNetSalary() {
    return calculateGrossSalary() - calculateTax();
  }

  void displaySalarySlip() {
    print("\n==========================================");
    print("          EMPLOYEE SALARY SLIP");
    print("==========================================");

    displayEmployeeInfo();

    print("\nBasic Salary : ₹$basicSalary");
    print("HRA          : ₹$hra");
    print("DA           : ₹$da");
    print("Bonus        : ₹$bonus");

    print("\nGross Salary : ₹${calculateGrossSalary()}");
    print("Tax          : ₹${calculateTax()}");
    print("Net Salary   : ₹${calculateNetSalary()}");

    print("==========================================");
  }
}

// Another Child Class
class Manager extends Salary {
  double performanceIncentive = 0;

  @override
  double calculateGrossSalary() {
    return basicSalary +
        hra +
        da +
        bonus +
        performanceIncentive;
  }

  @override
  void displaySalarySlip() {
    print("\n==========================================");
    print("          MANAGER SALARY SLIP");
    print("==========================================");

    displayEmployeeInfo();

    print("\nBasic Salary          : ₹$basicSalary");
    print("HRA                   : ₹$hra");
    print("DA                    : ₹$da");
    print("Bonus                 : ₹$bonus");
    print("Performance Incentive : ₹$performanceIncentive");

    print("\nGross Salary : ₹${calculateGrossSalary()}");
    print("Tax          : ₹${calculateTax()}");
    print("Net Salary   : ₹${calculateNetSalary()}");

    print("==========================================");
  }
}

void main() {
  // Creating Object
  Manager manager = Manager();

  // Taking User Input
  stdout.write("Enter Employee ID: ");
  manager.employeeId = stdin.readLineSync()!;

  stdout.write("Enter Employee Name: ");
  manager.employeeName = stdin.readLineSync()!;

  stdout.write("Enter Department: ");
  manager.department = stdin.readLineSync()!;

  stdout.write("Enter Basic Salary: ");
  manager.basicSalary = double.parse(stdin.readLineSync()!);

  stdout.write("Enter HRA: ");
  manager.hra = double.parse(stdin.readLineSync()!);

  stdout.write("Enter DA: ");
  manager.da = double.parse(stdin.readLineSync()!);

  stdout.write("Enter Bonus: ");
  manager.bonus = double.parse(stdin.readLineSync()!);

  stdout.write("Enter Performance Incentive: ");
  manager.performanceIncentive = double.parse(stdin.readLineSync()!);

  // Display Salary Slip
  manager.displaySalarySlip();
}
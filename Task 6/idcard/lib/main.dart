import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: IDCard()));
}

class IDCard extends StatelessWidget {
  const IDCard({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Student ID Card"),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Container(
            width: 240,
            height: 290,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xFFD9E7FF),
                  child: Icon(Icons.person, size: 70, color: Colors.blue),
                ),
                SizedBox(height: 15),
                Text(
                  "Amritansh Rai",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "B.Tech CSE",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(height: 15),
                Text(
                  "Roll No:101",
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

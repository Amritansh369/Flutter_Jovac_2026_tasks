import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    ),
  );
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isFollowing ? Colors.green : Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          isFollowing ? "Following Profile" : "Flutter Profile",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFFD9E7FF),
              child: Icon(
                Icons.person_2,
                size: 80,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Amritansh Rai",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Flutter Developer",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "amritansh.rai_cs24@gla.ac.in",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 35),

           ElevatedButton.icon(onPressed: (){
            setState(() {
              isFollowing=!isFollowing;
            });
           },
           style: ElevatedButton.styleFrom(
            backgroundColor: isFollowing?Colors.green:Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))            
           ),
           icon:Icon(
            isFollowing?Icons.check:Icons.person_add_outlined
           ),
           label: Text(
            isFollowing?"Following":"Follow",
            style: const TextStyle(fontSize: 20),
           ),
           )
          ],
        ),
      ),
    );
  }
}
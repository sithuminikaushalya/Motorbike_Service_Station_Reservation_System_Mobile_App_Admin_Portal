import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';

class LoginSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to BikePulse'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 126, 173, 244),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "keep your data safe",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            height: MediaQuery.of(context).size.height /
                1.8, // Adjust the height as needed
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/welcome.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          MaterialButton(
            minWidth: 150, // Set a specific width for the button
            height: 50,
            onPressed: () {
              // Navigate to login screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            // defining the shape
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            minWidth: 150, // Set a specific width for the button
            height: 50,
            onPressed: () {
              // Navigate to sign up screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            color: const Color.fromARGB(255, 14, 80, 132),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              "Sign up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'login_signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BikePulse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Color.fromARGB(255, 126, 173, 244), // Gold color for AppBar
        ),
      ),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: const Color.fromARGB(174, 231, 235, 178),
      end: const Color.fromARGB(255, 121, 109, 42),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Bike Reservation - Admin Portal', // Title in the AppBar
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(
                255, 45, 38, 3), // Dark color for better contrast
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _colorAnimation.value!,
                  const Color.fromARGB(255, 228, 233, 206),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: child,
          );
        },
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Align children at the center
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'Manage Your Bike Reservations Seamlessly',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Color.fromARGB(255, 45, 38, 3),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80.0), // Gap below the tagline text
            const SpinningImage(),
            const SizedBox(height: 40.0), // Gap below the image
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginSignupScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 121, 109, 42), // Gold color for button
                foregroundColor: Colors.white, // Button text color
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 13.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text("Get Started"),
            ),
            const SizedBox(height: 30.0), // Gap below the button
          ],
        ),
      ),
    );
  }
}

class SpinningImage extends StatefulWidget {
  const SpinningImage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SpinningImageState createState() => _SpinningImageState();
}

class _SpinningImageState extends State<SpinningImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: RotationTransition(
        turns: _controller,
        child: Image.asset(
          'assets/logo.png',
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'), // Removed const
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Subscription Screen!',
              style: TextStyle(
                  fontSize: 18), // Adding a font size for better readability
              textAlign: TextAlign.center,
            ),
            const SizedBox(
                height:
                    20), // Adding some spacing between text and other widgets
            ElevatedButton(
              onPressed: () {
                // Add functionality here
              },
              child: const Text('Subscribe Now'), // A call-to-action button
            ),
          ],
        ),
      ),
    );
  }
}

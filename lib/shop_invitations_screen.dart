import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ShopInvitationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Invitations'), // No need for const here
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Shop Invitations Screen!',
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
              child: const Text('Start Shopping'), // A call-to-action button
            ),
          ],
        ),
      ),
    );
  }
}

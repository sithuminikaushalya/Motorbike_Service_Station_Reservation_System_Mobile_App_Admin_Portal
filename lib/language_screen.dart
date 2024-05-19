import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LanguageScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> languages = ['English', 'Sinhala', 'Tamil'];
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Language:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(languages[index]),
                  onTap: () {
                    setState(() {
                      selectedLanguage = languages[index];
                    });
                    // Implement language selection logic here
                  },
                  tileColor: selectedLanguage == languages[index]
                      ? Colors.blue.withOpacity(0.3)
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

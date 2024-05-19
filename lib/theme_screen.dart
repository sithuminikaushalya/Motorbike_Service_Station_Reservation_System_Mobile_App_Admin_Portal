import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

// ignore: use_key_in_widget_constructors
class ThemeScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  List<String> themes = ['Light', 'Dark', 'System'];
  String selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Theme:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: themes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(themes[index]),
                  onTap: () {
                    setState(() {
                      selectedTheme = themes[index];
                    });
                    ThemeMode themeMode;
                    if (selectedTheme == 'Light') {
                      themeMode = ThemeMode.light;
                    } else if (selectedTheme == 'Dark') {
                      themeMode = ThemeMode.dark;
                    } else {
                      themeMode = ThemeMode.system;
                    }
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setTheme(themeMode);
                  },
                  tileColor: selectedTheme == themes[index]
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

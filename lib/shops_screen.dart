import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ShopsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildShopItem('Shop 1', 'Description for shop 1', Icons.store),
          _buildShopItem('Shop 2', 'Description for shop 2', Icons.store),
          _buildShopItem('Shop 3', 'Description for shop 3', Icons.store),
          // Add more shop items as needed
        ],
      ),
    );
  }

  Widget _buildShopItem(String title, String description, IconData icon) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        onTap: () {
          // Add functionality for each shop item
        },
      ),
    );
  }
}

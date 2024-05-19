import 'package:flutter/material.dart';
// ignore: unused_import
import 'shop_service.dart'; // Import the service class

// Define a Shop model
class Shop {
  final String shopName;
  final String shopAddress;

  Shop({required this.shopName, required this.shopAddress});
}

// Sample service class to simulate fetching shops
class ShopService {
  final String url;

  ShopService(this.url);

  Future<List<Shop>> fetchShops() async {
    // Simulate a network call with a delay
    await Future.delayed(const Duration(seconds: 2));
    return [
      Shop(shopName: 'Default Shop 1', shopAddress: 'Default Address 1'),
      Shop(shopName: 'Default Shop 2', shopAddress: 'Default Address 2'),
    ];
  }
}

// ignore: use_key_in_widget_constructors
class ShopsScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ShopsScreenState createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  late Future<List<Shop>> futureShops;
  final shopService = ShopService(
      'http://localhost:8095/shop/getShop'); // Replace with your actual backend URL

  @override
  void initState() {
    super.initState();
    futureShops = shopService.fetchShops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
        centerTitle: true,
        elevation: 4,
      ),
      body: FutureBuilder<List<Shop>>(
        future: futureShops,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No shops available'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: snapshot.data!
                .map((shop) => _buildShopItem(
                    shop.shopName, shop.shopAddress, Icons.store))
                .toList(),
          );
        },
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
          // Add functionality for each shop item if needed
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ShopsScreen(),
  ));
}

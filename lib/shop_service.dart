import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

// Model class representing a Shop
class Shop {
  final int shopId;
  final String shopName;
  final String shopAddress;

  Shop(
      {required this.shopId,
      required this.shopName,
      required this.shopAddress});

  // Factory constructor to create a Shop instance from JSON data
  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shopId'],
      shopName: json['shopName'],
      shopAddress: json['shopAddress'],
    );
  }
}

// Service class to handle HTTP requests to the backend
class ShopService {
  final String baseUrl; // Base URL of the backend

  ShopService(this.baseUrl);

  // Method to fetch the list of shops from the backend
  Future<List<Shop>> fetchShops() async {
    final response = await http.get(Uri.parse('$baseUrl/shop/getShop'));

    if (response.statusCode == 200) {
      // If the server returns a successful response, parse the JSON data
      List<dynamic> data = json.decode(response.body);
      return data.map((shop) => Shop.fromJson(shop)).toList();
    } else {
      // If the server returns an error, throw an exception
      throw Exception('Failed to load shops');
    }
  }
}

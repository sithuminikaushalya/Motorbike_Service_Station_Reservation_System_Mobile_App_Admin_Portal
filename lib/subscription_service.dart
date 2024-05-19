import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

// Define the SubscriptionPlan model
class SubscriptionPlan {
  final int id;
  String name;
  String description;
  String price;
  bool selected;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.selected = false,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['subscriptionPlanId'],
      name: json['subscriptionPlanName'],
      description: json['subscriptionPlanDescription'],
      price: json['subscriptionPlanPrice'],
      selected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subscriptionPlanId': id,
      'subscriptionPlanName': name,
      'subscriptionPlanDescription': description,
      'subscriptionPlanPrice': price,
    };
  }
}

class SubscriptionService {
  final String baseUrl;

  SubscriptionService(this.baseUrl);

  Future<List<SubscriptionPlan>> fetchPlans() async {
    final response = await http.get(Uri.parse('$baseUrl/subscriptionPlan'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => SubscriptionPlan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load subscription plans');
    }
  }

  Future<void> savePlans(List<SubscriptionPlan> plans) async {
    final response = await http.put(
      Uri.parse('$baseUrl/updateMultipleSubscriptionPlans'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(plans.map((plan) => plan.toJson()).toList()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save subscription plans');
    }
  }

  Future<void> addPlan(SubscriptionPlan plan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/addSubscriptionPlan'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(plan.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add subscription plan');
    }
  }
}

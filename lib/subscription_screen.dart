import 'package:flutter/material.dart';
// ignore: unused_import
import 'subscription_service.dart';

// Define a SubscriptionPlan model
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
}

// Sample service class to simulate fetching subscription plans
class SubscriptionService {
  final String url;

  SubscriptionService(this.url);

  Future<List<SubscriptionPlan>> fetchPlans() async {
    // Simulate a network call with a delay
    await Future.delayed(const Duration(seconds: 2));
    return [
      SubscriptionPlan(
          id: 1, name: 'Plan 1', description: 'Description 1', price: '10.00'),
      SubscriptionPlan(
          id: 2, name: 'Plan 2', description: 'Description 2', price: '20.00'),
      SubscriptionPlan(
          id: 3, name: 'Plan 3', description: 'Description 3', price: '30.00'),
    ];
  }

  Future<void> savePlans(List<SubscriptionPlan> plans) async {
    // Simulate a network call with a delay
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> addPlan(SubscriptionPlan plan) async {
    // Simulate a network call with a delay
    await Future.delayed(const Duration(seconds: 2));
  }
}

// ignore: use_key_in_widget_constructors
class SubscriptionScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late Future<List<SubscriptionPlan>> futurePlans;
  final subscriptionService = SubscriptionService(
      'http://localhost:8096/subscriptionPlan/subscriptionPlan'); // Replace with your actual backend URL

  List<SubscriptionPlan> plans = [];
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    futurePlans = subscriptionService.fetchPlans();
    futurePlans.then((fetchedPlans) {
      setState(() {
        plans = fetchedPlans;
      });
    });
  }

  void handleSave() {
    setState(() {
      editMode = false;
    });
    subscriptionService.savePlans(plans).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plans saved successfully')));
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error saving plans: $error')));
    });
  }

  void handleAddPlan(String name, String description, String price) {
    final newPlan = SubscriptionPlan(
        id: plans.length + 1,
        name: name,
        description: description,
        price: price);
    setState(() {
      plans.add(newPlan);
    });
    subscriptionService.addPlan(newPlan).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plan added successfully')));
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error adding plan: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans Management'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<SubscriptionPlan>>(
                future: futurePlans,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No plans available'));
                  }

                  return ListView.builder(
                    itemCount: plans.length,
                    itemBuilder: (context, index) {
                      final plan = plans[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: Checkbox(
                            value: plan.selected,
                            onChanged: (bool? value) {
                              setState(() {
                                plan.selected = value!;
                              });
                            },
                          ),
                          title: Text(plan.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description: ${plan.description}'),
                              Text('Price: ${plan.price}'),
                              if (plan.selected)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      decoration: const InputDecoration(
                                          labelText: 'Plan Name'),
                                      onChanged: (value) {
                                        setState(() {
                                          plan.name = value;
                                        });
                                      },
                                      readOnly: !editMode,
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(
                                          labelText: 'Description'),
                                      onChanged: (value) {
                                        setState(() {
                                          plan.description = value;
                                        });
                                      },
                                      readOnly: !editMode,
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(
                                          labelText: 'Price'),
                                      onChanged: (value) {
                                        setState(() {
                                          plan.price = value;
                                        });
                                      },
                                      readOnly: !editMode,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Add New Plan'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: nameController,
                              decoration:
                                  const InputDecoration(labelText: 'Plan Name'),
                            ),
                            TextField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                  labelText: 'Description'),
                            ),
                            TextField(
                              controller: priceController,
                              decoration:
                                  const InputDecoration(labelText: 'Price'),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              handleAddPlan(
                                nameController.text,
                                descriptionController.text,
                                priceController.text,
                              );
                              nameController.clear();
                              descriptionController.clear();
                              priceController.clear();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Add New Plan'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    editMode = !editMode;
                  });
                },
                child: Text(editMode ? 'Save' : 'Edit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SubscriptionScreen(),
  ));
}

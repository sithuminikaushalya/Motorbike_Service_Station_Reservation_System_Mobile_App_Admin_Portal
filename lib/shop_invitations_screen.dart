import 'package:flutter/material.dart';
import 'shop_invitation.dart';

// ignore: use_key_in_widget_constructors
class ShopInvitationsScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ShopInvitationsScreenState createState() => _ShopInvitationsScreenState();
}

class _ShopInvitationsScreenState extends State<ShopInvitationsScreen> {
  List<ShopInvitation> invitations = [
    ShopInvitation(id: 1, shopName: 'Shop 1', shopDetails: 'Details of Shop 1'),
    ShopInvitation(id: 2, shopName: 'Shop 2', shopDetails: 'Details of Shop 2'),
    // Add more invitations as needed
  ];

  void acceptInvitation(int id) {
    setState(() {
      invitations.removeWhere((invitation) => invitation.id == id);
    });
    // Implement backend call to accept the invitation here
  }

  void deleteInvitation(int id) {
    setState(() {
      invitations.removeWhere((invitation) => invitation.id == id);
    });
    // Implement backend call to delete the invitation here
  }

  void showDetails(ShopInvitation invitation) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(invitation.shopName),
          content: Text(invitation.shopDetails),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Invitations'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: invitations.length,
        itemBuilder: (context, index) {
          final invitation = invitations[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                invitation.shopName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                invitation.shopDetails,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () => acceptInvitation(invitation.id),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteInvitation(invitation.id),
                  ),
                ],
              ),
              onTap: () => showDetails(invitation),
            ),
          );
        },
      ),
    );
  }
}

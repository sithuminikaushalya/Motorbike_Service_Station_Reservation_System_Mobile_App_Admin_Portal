import 'package:flutter/material.dart';
import 'shops_screen.dart';
import 'shop_invitations_screen.dart';
import 'shop_payment_screen.dart';
import 'subscription_screen.dart';
import 'settings_screen.dart';

// ignore: use_key_in_widget_constructors
class SecondScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Text(
              'Control shops in your hands',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF51259B),
              ),
            ),
          ),
          Expanded(
            child: _buildBody(),
          ),
          _buildAnimatedLine(),
        ],
      ),
      bottomNavigationBar: _buildCustomBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildListItem(
            'Shop Invitations', Icons.email, ShopInvitationsScreen()),
        _buildListItem('Shop Payment', Icons.payment, ShopPaymentScreen()),
        _buildListItem(
            'Subscription', Icons.subscriptions, SubscriptionScreen()),
      ],
    );
  }

  Widget _buildListItem(String title, IconData icon, Widget screen) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedLine() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 4,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildCustomBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        if (_currentIndex == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShopsScreen()),
          );
        } else if (_currentIndex == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsScreen()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Shops',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SecondScreen(),
  ));
}

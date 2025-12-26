import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Methods", style: TextStyle(color: Color(0xffffffff)),)),
      body: Column(
        children: const [
          ListTile(title: Text("Online Payment")),
          ListTile(title: Text("UPI")),
          ListTile(title: Text("Cash on Delivery")),
        ],
      ),
    );
  }
}

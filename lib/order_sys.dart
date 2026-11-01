import 'package:flutter/material.dart';

class OrderSys extends StatelessWidget {
  const OrderSys({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('訂單系統'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('訂單${index+1}'),
            subtitle: Text('訂單內容'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
            Navigator.pushNamed(context, '/order_detail');
            },

          );
        },
      ),
    );
  }
}
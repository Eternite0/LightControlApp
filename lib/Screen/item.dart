import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Item> {

  double Val1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(value: Val1, onChanged: (value) {
            setState(() {
              Val1 = value;
            });
          })
        ],
      ),
    );
  }
}
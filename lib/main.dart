import 'package:flutter/material.dart';
import 'package:myproject/Screen/item.dart';

class Atest extends StatefulWidget {
  const Atest({super.key});

  @override
  State<Atest> createState() => _AtestState();
}

class _AtestState extends State<Atest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: const Text("Light Control",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const Item(),
    )
    );
    

  }
}

void main() {
  runApp(const Atest());
}

//MaterialApp(
    // title: "My Title",
    // // Scaffold(
    // //   appBar: AppBar(
    // //     title: const Text(
    // //       "Light Control",style: TextStyle(color: Colors.white,fontSize: 30)),
    // //     backgroundColor: Colors.black,
    // //     centerTitle: true,
    // //   ),
    // //   body: const Item(),
    // // ),
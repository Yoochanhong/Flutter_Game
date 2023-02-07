import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(color: Colors.blue),
          ),
          Expanded(
            child: Container(color: Colors.brown),
          ),
        ],
      ),
    );
  }
}

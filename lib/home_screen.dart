import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Text("Login Success.",style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _MyWidgetState();
  
}

class _MyWidgetState extends State<SettingsPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: const Text('Settings'),
        foregroundColor: Colors.white,
      ),
      
    );
  }
}
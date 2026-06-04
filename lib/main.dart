import 'package:flutter/material.dart';
import 'package:todo_app/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBar(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Container (
                  height: 100,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(Icons.favorite, size: 50, color: Colors.white),
                  ),
                )
              ]
            ),
          )
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('What to do?'),
        centerTitle: true,
        elevation: 0,
        leading: Icon(Icons.favorite),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Handle search action
            },
          ),
          SizedBox(width: 10),
        ],
        
      );
  }
}
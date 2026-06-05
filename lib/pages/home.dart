import 'package:flutter/material.dart';
import 'package:todo_app/pages/menu.dart';
import 'package:todo_app/widgets/global_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: GlobalAppBar(
        title: 'What to do?',
        onMenuPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      body: ListView(children: [_testContainer()]),
      floatingActionButton: _fabcon(),
      endDrawer: const AppDrawer(),
    );
  }

  FloatingActionButton _fabcon() {
    return FloatingActionButton(
      backgroundColor: Colors.pinkAccent,
      onPressed: () {
        debugPrint('FAB pressed');
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  Padding _testContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 500,

            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                221,
                166,
                184,
              ).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

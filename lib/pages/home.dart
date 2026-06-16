import 'package:flutter/material.dart';
import 'package:todo_app/pages/menu.dart';
import 'package:todo_app/widgets/global_app_bar.dart';
import 'package:todo_app/widgets/global_bottom_nav.dart';
import 'package:todo_app/widgets/global_fab.dart';
import 'package:todo_app/pages/addtodo.dart';
import 'package:todo_app/utilities/todo_tile.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('tasks');
    if (stored != null) {
      setState(() {
        tasks = stored.map((s) {
          final m = jsonDecode(s);
          return [m['name'] as String, m['done'] as bool];
        }).toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = tasks.map((t) => jsonEncode({'name': t[0], 'done': t[1]})).toList().cast<String>();
    await prefs.setStringList('tasks', stored);
  }

   void checkBoxChanged(bool? value, int index) {
    setState(() {
      tasks[index][1] = !(tasks[index][1] as bool);
    });
    _saveTasks();
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/calendar');
    }
  }
  


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

      
      body: ListView.builder(
       itemCount: tasks.length,
       itemBuilder: (context, index) {
        return ToDoTile(
          taskName: tasks[index][0] as String,
          taskCompleted: tasks[index][1] as bool,
          onChanged: (value) => checkBoxChanged(value, index),
        );
       }
      ),
      floatingActionButton: GlobalFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodo()),
            ).then((value) {
            if (value != null) {
              debugPrint('Returned task: $value');
              setState(() {
                tasks.add([value.toString(), false]);
              });
              _saveTasks();
            }
          });
        },
      ),
      bottomNavigationBar: GlobalBottomNav(
        currentIndex: 0,
        onTap: _onNavTap,
      ),
      endDrawer: const AppDrawer(),
    );
  }
}

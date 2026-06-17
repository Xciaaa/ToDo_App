import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/pages/menu.dart';
import 'package:todo_app/widgets/global_app_bar.dart';
import 'package:todo_app/widgets/global_bottom_nav.dart';
import 'package:todo_app/widgets/global_fab.dart';
import 'package:todo_app/pages/addtodo.dart';
import 'package:todo_app/utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _myBox = Hive.box('mybox');
  List tasks = [];

  @override
  void initState() {
    if (_myBox.get("TASKS") == null) {
      tasks = [
        ['ADD A TASK HERE', false],
      ];
    } else {
      tasks = _myBox.get("TASKS");
    }

    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      tasks[index][1] = !tasks[index][1];
    });
    _myBox.put("TASKS", tasks);
  }

  Future<void> deleteTask(BuildContext context, int index) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        
        return AlertDialog(
          title: const Text('DELETE TASK'),
          titleTextStyle: const TextStyle(color: Colors.white),
          content: Text("Are you sure you want to delete this?"),
          contentTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: const Color.fromARGB(200,221,166,184,),
          actions: [
            ElevatedButton(
              
              style: TextButton.styleFrom(
              foregroundColor: Colors.pinkAccent,
              backgroundColor: Colors.white ),
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white,
              backgroundColor: Colors.pinkAccent),
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    setState(() {
      tasks.removeAt(index);
    });
    _myBox.put("TASKS", tasks);
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/calendar');
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
            deleteFunction: (context) => deleteTask(context, index),
          );
        },
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
              _myBox.put("TASKS", tasks);
            }
          });
        },
      ),
      bottomNavigationBar: GlobalBottomNav(currentIndex: 0, onTap: _onNavTap),
      endDrawer: const AppDrawer(),
    );
  }
}

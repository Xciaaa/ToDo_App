import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    final task = _taskController.text.trim();
    if (task.isEmpty) {
      return;
    }
    Navigator.pop(context, task);
  }
  
  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('What do you want to do?'),
        foregroundColor: Colors.white,
      ),
      body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _taskController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.pinkAccent),
                    ),
                    hintText: 'Enter a task',
                    
                  ),
                ),
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.pinkAccent,
                    ),
                    onPressed: () => Navigator.pop(context), 
                    child: Text('CANCEL'),
                    ),
                  
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    ),
                    onPressed:(){
                    _addTask();
                    },
                    child: Text('ADD'),
                  ), 
                ],
              ),
            ],
      ),
    );
  }
}
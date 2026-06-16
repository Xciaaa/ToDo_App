import 'package:flutter/material.dart';


// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {

  final String taskName ;
  final bool taskCompleted;
  Function (bool?)? onChanged;

   ToDoTile({super.key, 
   required this.taskName, 
   required this.taskCompleted, 
   required this.onChanged
    }
   );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
              
            decoration: BoxDecoration(
              color: const Color.fromARGB(255,221,166,184,).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.pinkAccent,
                  ),

                 Text(taskName,
                  style: TextStyle(color: Colors.white, fontSize: 20, decoration: taskCompleted ? TextDecoration.lineThrough : null),
                  
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
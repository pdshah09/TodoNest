import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {

  final String title;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)?deleteFunction;


  TodoTile({
    super.key,
    required this.title,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.only(top:25,left: 25,right:25),
        child :Slidable(
            endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                      onPressed: deleteFunction,
                      icon: Icons.delete,
                      backgroundColor: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                  )
                ],
            ),
            child: GestureDetector(
            child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
                child: Row(
                    children:[

                      Checkbox(
                        value: taskCompleted,
                        onChanged: onChanged,
                        activeColor: const Color(0xFF3B82F6),
                        // checkColor: Colors.amber[300],
                        checkColor: Colors.white,
                        side: BorderSide(
                          // color: Colors.yellowAccent,
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),

                      Text(
                          title,
                          style: TextStyle(
                            decoration: taskCompleted ?
                                        TextDecoration.lineThrough:
                                        TextDecoration.none,
                            color: taskCompleted
                                ? Colors.grey
                                : const Color(0xFF1F2937), // Clay Charcoal
                          ),
                      )
                    ]
                ),
              ),
          onTap: () => onChanged?.call(!taskCompleted),
        )
        )
    );

  }
}

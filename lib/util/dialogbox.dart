import 'package:flutter/material.dart';
import 'package:todonest/util/button.dart';

class DialogBox extends StatelessWidget {

  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;


  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {

    return AlertDialog
      (
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        title: Text(
            "ADD NEW TASK",
            style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3B82F6), // Primary Blue
                    ),
        ),
        content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextField(
                controller: controller,
                cursorColor: Color(0xFF3B82F6),
                decoration: InputDecoration(
                  hintText: 'Enter Your Task',
                  border: OutlineInputBorder
                    (
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF3B82F6)
                    )
                  )
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    text: "SAVE",
                    backgroundColor: Colors.green,
                      onPressed: onSave,
                  ),
                  Button(
                    text: "CANCEL",
                    backgroundColor: Colors.red,
                    onPressed: onCancel,
                  ),
                ],
              )

            ],

          ),
        )

    );

  }
}

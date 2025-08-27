import 'package:flutter/material.dart';

class Button extends StatelessWidget{

  final String text;
  final Color backgroundColor;
  VoidCallback onPressed;

  Button({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.only(right: 12,left: 12,top: 15),
        child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          ),
        ),
        child: Text(
            text,
            style: TextStyle(
              color: Colors.white
            ),
        ),
    ));

  }

}
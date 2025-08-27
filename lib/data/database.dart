import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{

  List todoList = [];

  // reference hive box
  final _myBox = Hive.box('mybox');

  // first time ever
  void createInitialData(){
    todoList = [
      ["Task 1",false],
      ["Task 2",false],
      ["Task 3",false],
    ];
  }

  // load data from database
  void loadData(){
      todoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateData(){
      _myBox.put("TODOLIST",todoList);
  }

}
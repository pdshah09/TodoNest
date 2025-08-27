import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todonest/data/database.dart';
import 'package:todonest/util/dialogbox.dart';
import 'package:todonest/util/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();



  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState(){

    // if it is the first time ever
    if(_myBox.get("TODOLIST") == null){
        db.createInitialData();
    }
    else{
      // there exists
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  // List todoList = [
  //   ["Task 1",false],
  //   ["Task 2",false],
  //   ["Task 3",false],
  // ];

  void checkboxChanged(bool? value,int index){
      setState(() {
        db.todoList[index][1] = value;
      });
      db.updateData();
  }

  void saveNewTask(){
    final taskText = _controller.text.trim(); // Remove extra spaces

    // 1) Empty guard
    if (taskText.isEmpty) {

      Navigator.of(context).pop(); // Close dialog first
      _controller.clear();

      // Use Future.delayed to ensure dialog is closed before showing SnackBar
      Future.delayed(const Duration(milliseconds: 100), () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Task cannot be empty!"),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );
      });
      return;
    }

    // 2) Duplicate guard (case-insensitive)
    final isDuplicate = db.todoList.any((item) {
      final existing = (item[0] as String).trim().toLowerCase();
      return existing == taskText.toLowerCase();
    });

    if (isDuplicate) {

      Navigator.of(context).pop(); // Close dialog first
      _controller.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Task Already exists."),
            backgroundColor: Colors.greenAccent,
            duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // 3) Add + persist
    setState(() {
      db.todoList.add([taskText, false]); // Safely add the task
      _controller.clear();
    });
    db.updateData();
    Navigator.of(context).pop();
  }

  void createNewTask(){
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: ()  {
              _controller.clear();
              Navigator.of(context).pop();
            },
          );
        }
    );
  }

  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.yellow[200],
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xFF10B981), // Clay Mint Green
                Color(0xFF3B82F6), // Calm Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 8.0,
        scrolledUnderElevation: 4.0,
        centerTitle: true,
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
        titleTextStyle: GoogleFonts.varelaRound(
                  textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                  )
        ),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF3BF6E0), // Calm Blue
                Color(0xFF1E6D8A), // Deep Blue
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
              child : Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  "Left Slide Task To Delete.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child:ListView.builder(
                  itemCount: db.todoList.length,
                  itemBuilder: (context, index) => TodoTile(
                    title: db.todoList[index][0],
                    taskCompleted: db.todoList[index][1],
                    onChanged: (value) => checkboxChanged(value, index),
                    deleteFunction: (context) => deleteTask(index),
                  ),
                )),
              ),

            ],
          )
      )),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //
      //       const Text('You have pushed the button this many times:'),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //
      //
      //
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.yellowAccent,
        backgroundColor: const Color(0xFF3BDAF6),
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: createNewTask,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
        elevation: 8.0,
      ),
    );
  }
}

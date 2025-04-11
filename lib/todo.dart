import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String title;
  bool isCompleted;

  Task(this.title, this.isCompleted);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];

  TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      tasks[index].title,
                      style: TextStyle(
                        decoration: tasks[index].isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: tasks[index].isCompleted
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),
                    leading: Checkbox(
                      value: tasks[index].isCompleted,
                      onChanged: (value) {
                        setState(() {
                          tasks[index].isCompleted = value!;
                        });
                      },
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red[300]),
                      onPressed: () {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Add a new task',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      if (_taskController.text.isNotEmpty) {
                        setState(() {
                          tasks.add(Task(_taskController.text, false));
                          _taskController.clear();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

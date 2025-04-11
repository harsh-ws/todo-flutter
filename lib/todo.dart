import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String title;
  bool isCompleted;

  Task(this.title, this.isCompleted);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.dark(primary: Colors.teal),
        scaffoldBackgroundColor: Colors.grey[900],
        cardColor: Colors.grey[850],
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: TodoListScreen(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  TodoListScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];

  TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: tasks.isEmpty 
                ? Center(
                    child: Text(
                      'No tasks yet. Add one below!',
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  )
                : ListView.builder(
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
                                  ? (isDark ? Colors.grey[500] : Colors.grey)
                                  : (isDark ? Colors.white : Colors.black87),
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
              color: isDark ? Colors.grey[850] : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: isDark 
                      ? Colors.black.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.2),
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
                      hintStyle: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey[400]),
                      filled: true,
                      fillColor: isDark ? Colors.grey[800] : Colors.grey[50],
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

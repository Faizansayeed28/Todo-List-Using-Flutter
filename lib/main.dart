import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todos = [];

  void _addTask(String task) {
    if (task.length > 0) {
      setState(() {
        todos.add(task);
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _promtRevomeTask(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Mark as Done ${todos[index]} "),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel")),
              ElevatedButton(
                onPressed: () {
                  _removeTask(index);
                  Navigator.of(context).pop();
                },
                child: Text('MARK AS DONE'),
              ),
            ],
          );
        });
  }

  Widget _buildTodoList() {
    return new ListView.builder(itemBuilder: (context, index) {
      if (index < todos.length) {
        return _buildTodoItem(todos[index], index);
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _promtPage();
        },
        tooltip: "Add a Task",
        child: Icon(Icons.add),
      ),
    );
  }

  void _promtPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Add a new task"),
          ),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTask(val);
              Navigator.pop(context);
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }

  Widget _buildTodoItem(String todo, int index) {
    return ListTile(
      title: Text(todo),
      onTap: () => {_promtRevomeTask(index)},
    );
  }

  // This trailing comma makes auto-formatting nicer for build methods.

}

import '/api/api.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// ignore: camel_case_types

class dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoP = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        backgroundColor:Colors.redAccent,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: todoP.todos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    todoP.deleteTodo(todoP.todos[index]);
                  }),
              leading: Text
              (
                "User_id: "+todoP.todos[index].user_id.toString(),
                style: TextStyle(color:Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              title: Text(
                "Task_id: "+todoP.todos[index].id.toString()+"\n"
                +todoP.todos[index].title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Due_on: "+todoP.todos[index].description+" Status:"+todoP.todos[index].status,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ));
        },
      ),
     
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/todo.dart';

class TodosBottomSheet extends StatefulWidget {
  const TodosBottomSheet({
    Key? key,
    required Future<List<Todo>> todoList,
  })  : _todoList = todoList,
        super(key: key);

  final Future<List<Todo>> _todoList;

  @override
  State<TodosBottomSheet> createState() => _TodosBottomSheetState();
}

class _TodosBottomSheetState extends State<TodosBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
        future: widget._todoList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error!  ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: EdgeInsets.all(20.r),
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0.r),
                topRight: Radius.circular(25.0.r),
              ),
            ),
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var todo = snapshot.data![index];
                  return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: todo.completed,
                      title: Text(todo.title),
                      onChanged: (val) {
                        setState(() {
                          todo.completed = !todo.completed;
                        });
                      });
                }),
          );
        });
  }
}

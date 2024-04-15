import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/Widgets/textField.dart';
import 'package:task/firebase_services.dart';

import '../Widgets/text.dart';
class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FirebaseServices services=FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(Icons.arrow_back_ios),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text("ADD NEW TASKS", 20, FontWeight.w800, Colors.black),
                SizedBox(width: 10,),
                Icon(Icons.add_comment_outlined,color: Colors.black38,),
              ],
            ),
            SizedBox(height: 25,),
            text("What are you planning?", 14, FontWeight.normal, Colors.black45),
            SizedBox(height: 25,),
            textField(label: "Task Title",controller: titleController),
            textField(label: "Task Description",lines: 3, controller: descriptionController),
            SizedBox(height: 12,),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        )
                      ),
                      onPressed: (){
                        services.addTask(titleController, descriptionController);
                      }, child: text("Add Task", 16, FontWeight.w500, Colors.white),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/Widgets/textField.dart';
import 'package:task/firebase_services.dart';
import '../Widgets/text.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
                text("UPDATE TASKS", 20, FontWeight.w800, Colors.black),
                SizedBox(width: 10,),
                Icon(Icons.add_comment_outlined,color: Colors.black38,),
              ],
            ),
            SizedBox(height: 25,),
            text("What you want to update?", 14, FontWeight.normal, Colors.black45),
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
                        // services.updateTask(titleController, descriptionController, 12);
                      }, child: text("Update Task", 16, FontWeight.w500, Colors.white),),
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

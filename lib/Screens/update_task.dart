import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/user_provider.dart';
import 'package:task/Widgets/textField.dart';
import '../Widgets/text.dart';

class UpdateTask extends StatefulWidget {
  String titleController;
  String descriptionController;
  String docId;
  UpdateTask({super.key, required this.descriptionController,required this.titleController,required this.docId});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      title.text=widget.titleController;
      description.text=widget.descriptionController;
    });
    super.initState();
  }

  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<UserProfileProvider>(context);
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
            SizedBox(height: 22,),
            text("What you want to update?", 14, FontWeight.normal, Colors.black45),
            SizedBox(height: 25,),
            textField(label: "Task Title",controller: title),
            textField(label: "Task Description",lines: 3, controller: description),
            SizedBox(height: 12,),
            Row(
              children: [
                Expanded(
                  child: Consumer<UserProfileProvider>(
                    builder: (context, val, child) {
                      return SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple.shade400,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              )
                          ),
                          onPressed: (){
                            provider.updateTask(title, description, widget.docId);
                          }, child:
                            val.isLoading
                            ? Center(child: CupertinoActivityIndicator(color: Colors.white70,))
                            : text("Update Task", 16, FontWeight.w500, Colors.white),),
                      );
                    }
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

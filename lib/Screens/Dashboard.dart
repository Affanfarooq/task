import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/Screens/add_newTask.dart';
import 'package:task/Widgets/taskWidget.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNewTask()));
        },
        child: Material(
          borderRadius: BorderRadius.circular(12),
          elevation: 10,
          child: Container(
            width: 60,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.purple.shade800,
            ),
            child: Center(
              child: Icon(Icons.add,color: Colors.white70,),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                  itemCount: 6,
                  itemBuilder: (context,index){
                return TaskWidget();
              }),
            )
          ],
        ),
      ),
    );
  }
}

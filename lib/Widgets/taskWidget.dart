import 'package:flutter/material.dart';
import 'package:task/Widgets/text.dart';
class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8)
      ),
      duration: Duration(milliseconds: 600),
      child: ListTile(
        leading: Icon(Icons.check_circle,color: Colors.purple,),
        title: text("Done", 14, FontWeight.w500, Colors.black),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text("Description", 12, FontWeight.w500, Colors.black38),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  text("Date", 12, FontWeight.w500, Colors.black38),
                  text("SubDate", 12, FontWeight.w500, Colors.black38),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

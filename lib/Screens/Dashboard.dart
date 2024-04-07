import 'package:flutter/material.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Material(
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
    );
  }
}

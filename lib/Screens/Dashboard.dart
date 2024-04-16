import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/user_provider.dart';
import 'package:task/Screens/add_newTask.dart';
import 'package:task/Widgets/taskWidget.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../Models/user_model.dart';

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
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNewTask()));
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
              child: Icon(
                Icons.add,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Tasks')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Row(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 15, bottom: 15),
                          child: Text(
                            "No Task Upload Yet",
                            style: TextStyle(
                                color: Colors.black45, fontSize: 12),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final notices = snapshot.data!.docs;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: notices.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        return TimelineTile(
                          lineXY: 0.05,
                          isLast: snapshot.data!.size == index + 1
                              ? true
                              : false,
                          indicatorStyle: IndicatorStyle(
                            color: Colors.purple.shade100,
                            indicator: CircleAvatar(
                                backgroundColor: Colors.purple.shade100,
                                child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(fontSize: 12),
                                    ))),
                          ),
                          beforeLineStyle: LineStyle(
                              color: Colors.purple.shade400, thickness: 2),
                          afterLineStyle: LineStyle(
                              color: Colors.purple.shade400, thickness: 2),
                          endChild: Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 13, right: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 8,
                                    bottom: 12,
                                    top: 12),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['title'] ?? '',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black87),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data['description'] ?? '',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black45),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

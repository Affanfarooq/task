import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/theme_changer_provider.dart';
import 'package:task/Screens/add_newTask.dart';
import 'package:task/Screens/update_task.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
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
          child: Consumer<ThemeChanger>(builder: (context, val, child){
            return Container(
              width: 60,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: val.selectedColor,
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white70,
                ),
              ),
            );
          })
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
                    .where('userId',isEqualTo:  user!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Padding(
                      padding:
                      const EdgeInsets.only(left: 3, top: 15),
                      child: Column(
                        children: [
                          Container(
                            child: Transform.scale(
                              scale: 0.6,
                              child: Opacity(
                                opacity: 0.2,
                                child: Image.asset('Images/list.png'),
                              ),
                            ),
                          ),
                          Text(
                            "No Task Upload Yet",
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
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
                        Timestamp timestamp = data['timestamp'];
                        DateTime dateTime = timestamp.toDate(); // Convert timestamp to DateTime
                        String formattedDateTime =
                        DateFormat.yMMMd().add_jm().format(dateTime);
                        return Consumer<ThemeChanger>(builder: (context, val, child){
                            return TimelineTile(
                                lineXY: 0.05,
                                isLast: snapshot.data!.size == index + 1
                                    ? true
                                    : false,
                                indicatorStyle: IndicatorStyle(
                                  color: Colors.purple.shade100,
                                  indicator: CircleAvatar(
                                      backgroundColor: val.selectedColor,
                                      child: Center(
                                          child: Text(
                                            "${index + 1}",
                                            style: TextStyle(fontSize: 12,color: val.selectedColor==Colors.black87?Colors.white:Colors.white),
                                          ))),
                                ),
                                beforeLineStyle: LineStyle(
                                    color: val.selectedColor, thickness: 2),
                                afterLineStyle: LineStyle(
                                    color: val.selectedColor, thickness: 2),
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
                                          right: 10,
                                          bottom: 18,
                                          top: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data['title'] ?? '',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdateTask(titleController: data['title'],descriptionController: data['description'],docId: data['docId'],)));
                                                  }, icon: Icon(Icons.edit_outlined),),
                                                  IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline),)
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            data['description'] ?? '',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black45),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Posted on : ',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black26),
                                              ),
                                              Text(
                                                formattedDateTime,
                                                style: TextStyle(
                                                    fontSize: 11.5,
                                                    color: Colors.red.shade300),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                          });
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

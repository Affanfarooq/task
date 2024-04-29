import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {

  User? user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, val, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 40,),
                Container(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.black26,
                          child: CircleAvatar(
                            radius: 68,
                            backgroundImage: Image.network(
                                val.userProfile.image)
                                .image,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          child: IconButton(
                              onPressed: (){}, icon: Icon(Icons.camera_alt)))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  val.userProfile.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "Email : ${val.userProfile.email}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "Uid : ${user!.uid}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
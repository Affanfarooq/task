import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, userProfileProvider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name: ${userProfileProvider.userProfile.name}'),
                Text('Email: ${userProfileProvider.userProfile.email}'),
                // Add more profile information widgets as needed
              ],
            ),
          ),
        );
      },
    );
  }
}
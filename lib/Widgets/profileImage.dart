import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/authentication_provider.dart';


class ProfielPicCard extends StatefulWidget {
  const ProfielPicCard({Key? key}) : super(key: key);

  @override
  State<ProfielPicCard> createState() => _ProfielPicCardState();
}

class _ProfielPicCardState extends State<ProfielPicCard> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<AuthenticationProvider>(builder: (context, val, child){
          return Material(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
            ),
            child: CircleAvatar(
                radius: 65,
                backgroundColor: Colors.grey.shade100,
                child: val.profileImage.isEmpty?Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person,size: 70,color: Colors.black12,),
                  ],
                ),) :ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.grey.shade100,
                        child: Image.file(File(val.profileImage.toString()),fit: BoxFit.contain,)))
            ),
          );
        }),
        Positioned(
          right: 0,
          top: 10,
          child: Consumer<AuthenticationProvider>(builder: (context, val, child){
            return InkWell(
              onTap: (){
                val.getProfileImage();
              },
              child: CircleAvatar(
                backgroundColor:
                Colors.grey.withOpacity(0.3),
                radius: 20,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 1, bottom: 2),
                  child: Icon(Icons.add_a_photo,color: Colors.white,),
                ),
              ),
            );
          })
        )
      ],
    );
  }
}

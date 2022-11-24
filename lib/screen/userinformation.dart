import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

 Stream collectionStream = FirebaseFirestore.instance.collection('students').snapshots();
 Stream documentStream = FirebaseFirestore.instance.collection('students').doc('fname').snapshots();

class UserInformation extends StatefulWidget {
  @override
    _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _studentsStream = FirebaseFirestore.instance.collection('students').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _studentsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String?, dynamic> data = document.data()! as Map<String?, dynamic>;
          print(data);
            return ListTile(
              leading: CircleAvatar(
                          radius: 30,
                          child: FittedBox(child: Text(data['fname']),
                          ),
                        ),
              //title: Text(data['fname']),
              //subtitle: Text(data['company']),
            );
          }).toList(),
        );
      },
    );
  }
}
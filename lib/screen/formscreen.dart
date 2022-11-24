import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:testapp1/model/student.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  late Student myStudent = Student();

  CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection("students");

  Future<void> addUser(Student myStudent) {
    // Call the user's CollectionReference to add a new user
    return _studentCollection
        .add({
          "fname": myStudent.fname,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แบบฟอร์มบันทึกคะแนนสอบ"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ชื่อ",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    onSaved: (String? fname) {
                      myStudent.fname = fname;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text(
                          "บันทึกข้อมูล",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () async {
                          print(
                              "-----------------------------------------------------------------------");

                          formKey.currentState?.save();

                          await addUser(myStudent);

                          formKey.currentState?.reset();
                        }),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

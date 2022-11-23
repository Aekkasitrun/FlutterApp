//import 'package:cloud_firestore/cloud_firestore.dart';
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
  Student myStudent = Student();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  //เตรียม firebase

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );

            if (snapshot.connectionState == ConnectionState.done) {
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
                            Text(
                              "ชื่อ",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator:
                                  RequiredValidator(errorText: "กรุณาป้อนชื่อ"),
                              onSaved: (String? fname) {
                                myStudent.fname = fname;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "นามสกุล",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "กรุณาป้อนนามสกุล"),
                              onSaved: (String? lname) {
                                myStudent.lname = lname;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "อีเมล",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator: MultiValidator([
                                EmailValidator(
                                    errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                                RequiredValidator(errorText: "กรุณาป้อนอีเมล")
                              ]),
                              onSaved: (String? email) {
                                myStudent.email = email;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "คะแนน",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator:
                                  RequiredValidator(errorText: "กรุณาใส่คะแนน"),
                              onSaved: (String? score) {
                                myStudent.score = score;
                              },
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text(
                                  "บันทึกข้อมูล",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState?.save();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              );
            }

            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

        });
    
  }
}

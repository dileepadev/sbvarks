import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherModel {
  String uuid;
  String title;
  String firstName;
  String lastName;
  String email;
  String contactNumber;
  String password;
  String lastAppeared;
  String accountCreated;

  TeacherModel({
    required this.uuid,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.password,
    required this.lastAppeared,
    required this.accountCreated,
  });

  factory TeacherModel.fromJsom(DocumentSnapshot snapshot) {
    return TeacherModel(
      uuid: snapshot.id,
      title: snapshot['title'],
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      email: snapshot['email'],
      contactNumber: snapshot['contactNumber'],
      password: snapshot['password'],
      lastAppeared: snapshot['lastAppeared'],
      accountCreated: snapshot['accountCreated'],
    );
  }
}

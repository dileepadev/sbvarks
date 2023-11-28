class StudentModel {
  String firstName;
  String lastName;
  String picture;
  String index;
  String grade;
  String teacherID;
  String varkType;
  String valueV;
  String valueA;
  String valueR;
  String valueK;

  StudentModel({
    required this.firstName,
    required this.lastName,
    required this.picture,
    required this.index,
    required this.grade,
    required this.teacherID,
    required this.varkType,
    required this.valueV,
    required this.valueA,
    required this.valueR,
    required this.valueK,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      picture: map['picture'],
      index: map['index'],
      grade: map['grade'],
      teacherID: map['teacherID'],
      varkType: map['varkType'],
      valueV: map['valueV'],
      valueA: map['valueA'],
      valueR: map['valueR'],
      valueK: map['valueK'],
    );
  }
}

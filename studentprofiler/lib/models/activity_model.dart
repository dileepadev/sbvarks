import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  String generatedplanV1;
  String generatedplanV2;
  String generatedplanV3;
  String generatedplanV4;
  String generatedplanA1;
  String generatedplanA2;
  String generatedplanA3;
  String generatedplanA4;
  String generatedplanR1;
  String generatedplanR2;
  String generatedplanR3;
  String generatedplanR4;

  ActivityModel({
    required this.generatedplanV1,
    required this.generatedplanV2,
    required this.generatedplanV3,
    required this.generatedplanV4,
    required this.generatedplanA1,
    required this.generatedplanA2,
    required this.generatedplanA3,
    required this.generatedplanA4,
    required this.generatedplanR1,
    required this.generatedplanR2,
    required this.generatedplanR3,
    required this.generatedplanR4,
  });

  factory ActivityModel.fromJsom(DocumentSnapshot snapshot) {
    return ActivityModel(
      generatedplanV1: snapshot['generatedplanV1'],
      generatedplanV2: snapshot['generatedplanV2'],
      generatedplanV3: snapshot['generatedplanV3'],
      generatedplanV4: snapshot['generatedplanV4'],
      generatedplanA1: snapshot['generatedplanA1'],
      generatedplanA2: snapshot['generatedplanA2'],
      generatedplanA3: snapshot['generatedplanA3'],
      generatedplanA4: snapshot['generatedplanA4'],
      generatedplanR1: snapshot['generatedplanR1'],
      generatedplanR2: snapshot['generatedplanR2'],
      generatedplanR3: snapshot['generatedplanR3'],
      generatedplanR4: snapshot['generatedplanR4'],
    );
  }
}

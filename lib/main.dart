import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pain_prototype/app.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(PaintApp());
}

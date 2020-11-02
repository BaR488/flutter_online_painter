import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_painter/app.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(PaintApp());
}

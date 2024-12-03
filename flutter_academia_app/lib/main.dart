import 'package:flutter/material.dart';
import 'package:flutter_academia_app/home.dart';

void main() {
  runApp(
    MaterialApp(
      title: "BookMeNow",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const HomePage(),
    ),
  );
}

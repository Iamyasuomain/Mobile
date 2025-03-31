// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register(),
    );
  }
}

PreferredSizeWidget AppBarCustom(String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100.0),
    child: Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2F5241), // from Figma
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Container(
        height: 150,
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: [
            Center(
                child: Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold))),
            Positioned(
              top: -13,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.settings, color: Colors.white, size: 25,),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    ),
  );
}

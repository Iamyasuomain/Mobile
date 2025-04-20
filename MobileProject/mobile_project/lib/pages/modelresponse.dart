import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';

class Modelresponse extends StatefulWidget {
  final Map<String, dynamic>? base64image;

  const Modelresponse({
    super.key,
    this.base64image
  });

  @override
  State<Modelresponse> createState() => _ModelresponsState();
}

class _ModelresponsState extends State<Modelresponse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom("Response"),
      body: Center(child: Text("Hello"))
    );
  }
}
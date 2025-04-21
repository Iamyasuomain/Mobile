import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_project/pages/home.dart';

class Modelresponse extends StatefulWidget {
  final Map<String, dynamic>? predicted;

  const Modelresponse({
    super.key,
    this.predicted,
  });

  @override
  State<Modelresponse> createState() => _ModelresponsState();
}

class _ModelresponsState extends State<Modelresponse> {
  @override
  void initState() {
    super.initState();
  }

  Widget getPredictedValue(Map<String, dynamic>? predicted) {
    List<String> items = [];

    if (predicted != null) {
      var predictions = predicted['outputs'][0]['predictions']['predictions'];
      // Check if 'predictions' is not null and not empty
      if (predictions != null && predictions.isNotEmpty) {
        for (var i = 0; i < predictions.length; i++) {
          var detect_class = predictions[i]['class'];
          items.add(detect_class); // Add the detected class to the items list
        }
      }
    }

    // Show predictions if available, else show a message
    if (items.isNotEmpty) {
      if (items.contains('Bone')) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cancel,
                  color: HexColor("#FF0000"),
                  size: 50,
                ),
                const SizedBox(height: 10),
                Text(
                  "The model detect Bone so you can't put it in the machine",
                  style: TextStyle(
                    color: HexColor('#FF0000'),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ) // Join items into a string for display
              ],
            ),
          ),
        );
      } else {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: HexColor("#4FA64F"),
                  size: 50,
                ),
                SizedBox(height: 10),
                Text(
                  "The model detect " +
                      items.join(", ") +
                      " so you can put it in the machine",
                  style: TextStyle(
                    color: HexColor('#4FA64F'),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ) // Join items into a string for display
              ],
            ),
          ),
        );
      }
    } else {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel,
                color: HexColor("#FF0000"),
                size: 50,
              ),
              Text(
                "The Model can't detect your food waste please try again",
                style: TextStyle(
                  color: HexColor('#FF0000'),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Nav(text: 'Response'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getPredictedValue(widget.predicted),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
                child:
                    Text("Home", style: TextStyle(color: HexColor("#2F5241"))),
                backgroundColor: HexColor("#84B876"),
              ),
            ), // Back button
          ] // Display the dialog content
          ),
    );
  }
}

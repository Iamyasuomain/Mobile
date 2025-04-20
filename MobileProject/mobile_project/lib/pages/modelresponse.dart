import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';

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
          items.add(detect_class);  // Add the detected class to the items list
        }
      }
    }

    // Show predictions if available, else show a message
    if (items.isNotEmpty) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Container(
          width: 250,
          height: 150,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Predicted Value"),
              const SizedBox(height: 10),
              Text(items.join(", ")), // Join items into a string for display
            ],
          ),
        ),
      );
    } else {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Container(
          width: 250,
          height: 150,
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No predictions available"),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom("Response"),
      body: Center(
        child: getPredictedValue(widget.predicted), // Display the dialog content
      ),
    );
  }
}
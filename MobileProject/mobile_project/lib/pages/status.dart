import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_project/main.dart';
import 'package:mobile_project/pages/archievement.dart'; // Ensure this import is correct

void main() {
  runApp(const Status());
}

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Waste Statistics',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const StatPage(),
    );
  }
}

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  // Variables to store the food waste data
  double foodWastePercentage = 0.5; // 50% for Food Waste
  double foodScrapsPercentage = 0.35; // 35% for Food Scraps
  double foodResiduesPercentage = 0.15; // 15% for Food Residues

  // Method to update statistics (percentage)
  void updateStatistics(double foodWaste, double foodScraps, double foodResidues) {
    setState(() {
      foodWastePercentage = foodWaste;
      foodScrapsPercentage = foodScraps;
      foodResiduesPercentage = foodResidues;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(context, "Statistic"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Food waste reduction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Pie Chart (simulated using a circular progress indicator)
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: foodWastePercentage, // Dynamically set percentage
                    strokeWidth: 20,  // Increased strokeWidth for a thicker ring
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  Text(
                    'Food Waste ${(foodWastePercentage * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Data section with buttons
            Card(
              color: Colors.green[50],  // Lighter background color for the card
              elevation: 5,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Food Waste'),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        updateStatistics(0.5, foodScrapsPercentage, foodResiduesPercentage); // Example update
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Food Scraps'),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        updateStatistics(foodWastePercentage, 0.35, foodResiduesPercentage); // Example update
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Food Residues'),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        updateStatistics(foodWastePercentage, foodScrapsPercentage, 0.15); // Example update
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Achievement section
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(// Set the background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Archievement(),
                          ),
                        );
                      },
                      backgroundColor: const Color(0x8A8C89),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            FontAwesomeIcons.trophy,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Achievements',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

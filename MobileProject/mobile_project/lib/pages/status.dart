import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_project/main.dart';
import 'package:mobile_project/pages/archievement.dart';
import 'package:mobile_project/pages/stat_info/foodresidue.dart';
import 'package:mobile_project/pages/stat_info/foodscrap.dart';
import 'package:mobile_project/pages/stat_info/foodwaste.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pie_chart/pie_chart.dart';

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
  double foodWastePercentage = 0.5;
  double foodScrapsPercentage = 0.35;
  double foodResiduesPercentage = 0.15;

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        foodWastePercentage = data["Food Waste"] ?? 5;
        foodScrapsPercentage = data["Food Scraps"] ?? 35;
        foodResiduesPercentage = data["Food Residues"] ?? 15;
      });
    });
  }

  Future<Map<String, double>> fetchData() async {
    Map<String, double> dataMap = {
      "Food Waste": foodWastePercentage,
      "Food Scraps": foodScrapsPercentage,
      "Food Residues": foodResiduesPercentage,
    };

    return dataMap;
  }

  void updateStatistics(
      double foodWaste, double foodScraps, double foodResidues) {
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
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Food waste reduction',
              style: TextStyle(fontSize: 25),
            ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FutureBuilder<Map<String, double>>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Error loading data');
                      } else if (snapshot.hasData) {
                        return PieChart(
                          dataMap: snapshot.data!,
                          animationDuration: const Duration(milliseconds: 800),
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          ringStrokeWidth: 28,
                          initialAngleInDegree: 0,
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                        );
                      } else {
                        return const Text('No data available');
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: HexColor('#FBF6E9'),
              ),
              child: Column(
                spacing: 10,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('#84B876'),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodwastePage(),
                        ),
                      ),
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Food Waste",
                            style: TextStyle(
                                fontSize: 16, color: HexColor('#2F5241'))),
                        Icon(Icons.arrow_forward_ios,
                            color: HexColor('#2F5241')),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('#84B876'),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodresiduePage(),
                        ),
                      ),
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Food Residue",
                            style: TextStyle(
                                fontSize: 16, color: HexColor('#2F5241'))),
                        Icon(Icons.arrow_forward_ios,
                            color: HexColor('#2F5241')),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('#84B876'),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodscrapPage(),
                        ),
                      ),
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Food Scrap",
                            style: TextStyle(
                                fontSize: 16, color: HexColor('#2F5241'))),
                        Icon(Icons.arrow_forward_ios,
                            color: HexColor('#2F5241')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FittedBox(
              // Adjust the width as needed
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Archievement(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor('#8A8C89'),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center-align content
                  children: [
                    Icon(FontAwesomeIcons.trophy,
                        color: HexColor('#FFFF79')), // Trophy icon
                    const SizedBox(width: 10),
                    Text(
                      "Achievements",
                      style: TextStyle(color: HexColor('#FFFF79')),
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

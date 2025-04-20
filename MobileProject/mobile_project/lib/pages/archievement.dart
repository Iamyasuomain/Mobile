import "package:flutter/material.dart";
import "package:mobile_project/main.dart";

class Archievement extends StatelessWidget {
  const Archievement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5E655F),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Nav(text: 'Archievement'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF8A8C89),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    //bar
                    Bar(
                      icon: Icons.star,
                      text: "The first addition of food waste",
                    ),
                    Bar(
                      icon: Icons.grain,
                      text: "The first use of the fertilizer",
                    ),
                    Bar(
                      icon: Icons.remove_circle_outline,
                      text: "Reduce food waste (50 kg)",
                    ),
                    Bar(
                      icon: Icons.cloud_outlined,
                      text: "CO2 emission reduction (50 CO2e)",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final IconData icon;
  final String text;
  const Bar({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFD1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(18),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

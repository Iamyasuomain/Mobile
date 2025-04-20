import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Overall extends StatefulWidget {
  const Overall({super.key});

  @override
  State<Overall> createState() => _OverallState();
}

class _OverallState extends State<Overall> {
  final DatabaseReference _tempRef =
      FirebaseDatabase.instance.ref('ESP/Temperature');
  final DatabaseReference _humRef =
      FirebaseDatabase.instance.ref('ESP/Humidity');
  String overallCondition = "";
  Color conditionColor = Colors.red;
  String latestalert = "";
  double _temperature = 0;
  double _humidity = 0;
  @override
  void initState() {
    super.initState();
    _tempRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _temperature = double.tryParse(data.toString()) ?? 0;
          _updateCondition();
        });
      }
    });

    _humRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _humidity = double.tryParse(data.toString()) ?? 0;
          _updateCondition();
        });
      }
    });
  }

  void _updateCondition() {
    overallCondition = _temperature < 18 || _humidity < 40
        ? "แย่"
        : _temperature > 30 || _humidity > 60
            ? "ดี"
            : "พอใช้";
    conditionColor = overallCondition == "ดี"
        ? Colors.green
        : overallCondition == "พอใช้"
            ? Colors.yellow
            : Colors.red;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(context, 'สถานะอุปกรณ์'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StatusCard(),
            const SizedBox(height: 50),
            ValuesCard(),
            const SizedBox(height: 50),
            LatestAlertTimestampCard()
          ],
        ),
      ),
    );
  }

  Widget LatestAlertTimestampCard() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return SizedBox();

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('alerts')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        String displayText = "ยังไม่มีการแจ้งเตือน";
        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final timestamp = data['timestamp'];
          if (timestamp != null) {
            displayText =
                DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp.toDate());
          }
        }

        return Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: Colors.blueAccent),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'การแจ้งเตือนล่าสุด',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        displayText,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget StatusCard() {
    return Card(
      margin: const EdgeInsets.only(top: 60),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: conditionColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                overallCondition == "ดี"
                    ? Icons.check_circle
                    : overallCondition == "พอใช้"
                        ? Icons.warning
                        : Icons.error,
                color: conditionColor,
                size: 40,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'สถานะปัจจุบัน',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    overallCondition,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: conditionColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ValuesCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.thermostat, color: Colors.redAccent),
                      const SizedBox(width: 8),
                      const Text(
                        'อุณหภูมิ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_temperature °C',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  bar(
                    _temperature,
                    0,
                    30,
                    _temperature < 18
                        ? Colors.blue
                        : _temperature > 30
                            ? Colors.red
                            : Colors.green,
                  ),
                ],
              ),
            ),
            const VerticalDivider(thickness: 1, width: 32, color: Colors.grey),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.water_drop, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                      const Text(
                        'ความชื้น',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_humidity %RH',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  bar(
                    _humidity,
                    0,
                    100,
                    _humidity < 40
                        ? Colors.orange
                        : _humidity > 70
                            ? Colors.purple
                            : Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bar(double value, double min, double max, Color color) {
    double percent = (value - min) / (max - min);
    percent = percent.clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(3),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: percent,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}

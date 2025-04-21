import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_project/main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDeviceConnected = false;
  String? userEmail;
  int? lastUpdateTimestamp;
  late DatabaseReference _sensorRef;
  late Stream<DatabaseEvent> _sensorStream;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userEmail = user?.email;
    checkDeviceConnection();
    _sensorRef = FirebaseDatabase.instance.ref().child('ESP');
    _sensorStream = _sensorRef.onValue;
  }

  // Simulate a device connection check
  void checkDeviceConnection() {
    if (lastUpdateTimestamp != null) {
      DateTime currentTime = DateTime.now();
      DateTime lastUpdateTime =
          DateTime.fromMillisecondsSinceEpoch(lastUpdateTimestamp!);
      Duration difference = currentTime.difference(lastUpdateTime);
      if (difference.inSeconds >= 7) {
        setState(() {
          isDeviceConnected = false;
        });
      } else {
        setState(() {
          isDeviceConnected = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(context, 'Home'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Section
            Text(
              'Hello, ${userEmail ?? userEmail ?? 'User'}!',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            StreamBuilder<DatabaseEvent>(
              stream: _sensorStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  Map<dynamic, dynamic> data =
                      Map.from(snapshot.data!.snapshot.value as Map);
                  lastUpdateTimestamp = data['Timestamp'];

                  // Check if the device is connected or not
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    checkDeviceConnection();
                  });

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF6E9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Device status",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Device: ${isDeviceConnected ? 'Connected' : 'Not Connected'}\nStatus: ${isDeviceConnected ? 'Ready' : 'Not Ready'}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Icon(
                          isDeviceConnected ? Icons.check_circle : Icons.cancel,
                          color: isDeviceConnected ? Colors.green : Colors.red,
                          size: 200,
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox(); // Empty return if no data is received
              },
            ),
            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF6E9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Text(
                    'Connect to your device',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Open your mobile and connect to the wifi that is connected to the device.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

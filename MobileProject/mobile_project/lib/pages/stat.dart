import 'dart:async';
import 'package:mobile_project/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Stat extends StatefulWidget {
  const Stat({super.key});

  @override
  _StatState createState() => _StatState();
}

class _StatState extends State<Stat> {
  final DatabaseReference _tempRef = FirebaseDatabase.instance.ref('ESP/Temperature');
  final DatabaseReference _humRef = FirebaseDatabase.instance.ref('ESP/Humidity');

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
        });
      }
    });

    _humRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _humidity = double.tryParse(data.toString()) ?? 0;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildGauge(String label, double value, String unit, String type) {
    Color getGaugeColor() {
      if (type == "temperature") {
        if (value < 10) return Colors.blueAccent; 
        if (value >= 10 && value < 25) return Colors.green;  
        if (value >= 25 && value < 35) return Colors.yellow; 
        return Colors.red;  
      } else if (type == "humidity") {
        if (value < 30) return Colors.lightBlue;
        if (value >= 30 && value < 60) return Colors.green;
        return Colors.red;
      }
      return Colors.grey; 
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                startAngle: 180,
                endAngle: 0,
                minimum: 0,
                maximum: 100,
                showTicks: false,
                showLabels: false,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.2,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 0,
                    endValue: 33,
                    color: getGaugeColor(),
                    startWidth: 0.2,
                    endWidth: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                  GaugeRange(
                    startValue: 33,
                    endValue: 66,
                    color: getGaugeColor(),
                    startWidth: 0.2,
                    endWidth: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                  GaugeRange(
                    startValue: 66,
                    endValue: 100,
                    color: getGaugeColor(),
                    startWidth: 0.2,
                    endWidth: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                    enableAnimation: true,
                    animationType: AnimationType.ease,
                    animationDuration: 1000,
                    value: value,
                    needleLength: 0.7,
                    lengthUnit: GaugeSizeUnit.factor,
                    needleStartWidth: 1,
                    needleEndWidth: 5,
                    knobStyle: const KnobStyle(
                      knobRadius: 0.07,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      '${value.toStringAsFixed(1)} $unit',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.35,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(context,'Status'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildGauge('Temperature', _temperature, '°C', 'temperature'),
            buildGauge('Humidity', _humidity, '%RH', 'humidity'),
          ],
        ),
      ),
    );
  }
}

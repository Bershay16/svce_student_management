// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math';

class MarksCalculator extends StatefulWidget {
  static double internalMarks = 0.00;

  const MarksCalculator({super.key});

  @override
  _MarksCalculatorState createState() => _MarksCalculatorState();
}

class _MarksCalculatorState extends State<MarksCalculator> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController cat1Controller = TextEditingController();
  final TextEditingController cat2Controller = TextEditingController();
  final TextEditingController cat3Controller = TextEditingController();
  final TextEditingController assignment1Controller = TextEditingController();
  final TextEditingController assignment2Controller = TextEditingController();
  final TextEditingController assignment3Controller = TextEditingController();

  bool isCelebrating = false;

  void calculateInternalMarks() {
    if (_formKey.currentState!.validate()) {
      int cat1 = int.tryParse(cat1Controller.text) ?? 0;
      int cat2 = int.tryParse(cat2Controller.text) ?? 0;
      int cat3 = int.tryParse(cat3Controller.text) ?? 0;
      int assignment1 = int.tryParse(assignment1Controller.text) ?? 0;
      int assignment2 = int.tryParse(assignment2Controller.text) ?? 0;
      int assignment3 = int.tryParse(assignment3Controller.text) ?? 0;

      double totalCats = (cat1 + cat2 + cat3) * 0.7;
      double totalAssignments = (assignment1 + assignment2 + assignment3) * 0.3;
      MarksCalculator.internalMarks = ((totalCats + totalAssignments) / 3) * 0.8;

      setState(() {
        isCelebrating = true;
      });
    }
  }

  Widget buildTextField(
      String label, TextEditingController controller, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          final val = int.tryParse(value);
          if (val == null || val < 0 || val > 50) {
            return 'Marks should be between 0 and 50';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: color),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Internal Marks Calculator',
          style: TextStyle(
            fontSize: 17
          ),
          ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue[25],
              child: Stack(
                children: [
                  Opacity(
                    opacity: isCelebrating ? 0.3 : 1.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            buildTextField("Enter CAT1 marks", cat1Controller,
                                Colors.blueAccent),
                            buildTextField("Enter CAT2 marks", cat2Controller,
                                Colors.blueAccent),
                            buildTextField("Enter CAT3 marks", cat3Controller,
                                Colors.blueAccent),
                            buildTextField(
                                "Enter Assignment1 marks",
                                assignment1Controller,
                                Colors.purple),
                            buildTextField(
                                "Enter Assignment2 marks",
                                assignment2Controller,
                                Colors.purple),
                            buildTextField(
                                "Enter Assignment3 marks",
                                assignment3Controller,
                                Colors.purple),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: calculateInternalMarks,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text('Calculate Internal Marks'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (isCelebrating)
                    CelebrationScreen(onDismiss: () {
                      setState(() {
                        isCelebrating = false;
                      });
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CelebrationScreen extends StatefulWidget {
  final VoidCallback onDismiss;

  const CelebrationScreen({required this.onDismiss, super.key});

  @override
  _CelebrationScreenState createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Spark> _sparks;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _sparks = List.generate(1000, (index) {
      final angle = Random().nextDouble() * 2 * pi;
      final distance = Random().nextDouble() * 500 + 100;
      final sparkleSpeed = Random().nextDouble() * 0.5 + 0.5;
      return Spark(
        angle: angle,
        distance: distance,
        maxSize: Random().nextDouble() * 3 + 1,
        sparkleSpeed: sparkleSpeed,
      );
    });

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: SparklePainter(_controller.value, _sparks),
                child:
                    SizedBox(width: double.infinity, height: double.infinity),
              );
            },
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Internal Marks: ${MarksCalculator.internalMarks.toStringAsFixed(2)} / 40",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                GestureDetector(
                  onTap: widget.onDismiss,
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.purple]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Done",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Spark {
  final double angle;
  final double distance;
  final double maxSize;
  final double sparkleSpeed;

  Spark({
    required this.angle,
    required this.distance,
    required this.maxSize,
    required this.sparkleSpeed,
  });
}

class SparklePainter extends CustomPainter {
  final double animationValue;
  final List<Spark> sparks;

  SparklePainter(this.animationValue, this.sparks);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint();

    for (var spark in sparks) {
      final offset = Offset(
        center.dx + spark.distance * animationValue * cos(spark.angle),
        center.dy + spark.distance * animationValue * sin(spark.angle),
      );

      double sparkleOpacity =
          0.5 + 0.5 * sin(animationValue * pi * 4 * spark.sparkleSpeed);
      paint.color = Colors.orange.withOpacity(sparkleOpacity);

      canvas.drawCircle(offset, spark.maxSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

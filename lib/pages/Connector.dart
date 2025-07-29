import 'package:flutter/material.dart';
import 'package:svce_student_management/pages/funtions.dart';
import 'package:svce_student_management/pages/image_slider.dart';

class ConnectorWidget extends StatelessWidget {
  const ConnectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  ImageSlider(),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 350,
                    child: GridView1(),
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

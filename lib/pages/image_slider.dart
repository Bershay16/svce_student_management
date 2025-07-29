// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:svce_student_management/imagePages/Page2.dart';
import 'package:svce_student_management/imagePages/Page3.dart';
import 'package:svce_student_management/imagePages/Page4.dart';

class ImageSlider extends StatelessWidget {
  ImageSlider({super.key});
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView(
            controller: _controller,
            children: const [
              Page4(),
              Page2(),
              Page3(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:10),
          child: SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.blue,
              dotHeight: 12,
              dotWidth: 12,
              spacing: 8,
            ),
          ),
        ),
      ],
    );
  }
}

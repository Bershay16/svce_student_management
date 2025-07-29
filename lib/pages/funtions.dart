import 'package:flutter/material.dart';
import 'package:svce_student_management/FunctionPages/page1.dart';
import 'package:svce_student_management/FunctionPages/page2.dart';
import 'package:svce_student_management/FunctionPages/page3.dart';
import 'package:svce_student_management/FunctionPages/page4.dart';
import 'package:svce_student_management/FunctionPages/page5.dart';
import 'package:svce_student_management/FunctionPages/page6.dart';
import 'package:svce_student_management/FunctionPages/page7.dart';
import 'package:svce_student_management/FunctionPages/page8.dart';
//import 'package:svce_student_management/FunctionPages/page9.dart';
import 'package:svce_student_management/FunctionPages/pcd.dart';

const Color primaryBlue = Color(0xFF1D4ED8);
const Color secondaryGray = Color(0xFFF1F5F9);
const Color accentGreen = Color(0xFF10B981);
const Color darkText = Color(0xFF111827);
const Color black = Color.fromARGB(255, 0, 0, 0);
const Color purple = Colors.purple;

class GridView1 extends StatelessWidget {
  static const List<String> icons = [
    'assets/icons/checking-attendance.png',
    'assets/icons/calendar.png',
    'assets/icons/growth.png',
    'assets/icons/mission.png',
    'assets/icons/check.png',
    'assets/icons/pcd.png',
    'assets/icons/coin.png',
    'assets/icons/rating.png',
    'assets/icons/announcement.png',
  ];

  final List<String> placeNames = [
    "Attendance",
    "Class Schedule",
    "Result",
    "Internal Mark",
    "OD Apply",
    "PCD",
    "Fees Paid",
    "Grievance Redressal",
    "Announcement",
  ];

  final List<Widget> pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
    Page5(),
    PCD(),
    Page6(),
    Page7(),
    Page8(),
  ];

  GridView1({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 8,
        
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        
        return GestureDetector(
          onTap: () {
            // Navigation
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pages[index],
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                gradient:LinearGradient(colors: [Colors.blueAccent.shade700, Colors.blue.shade400]),
                
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      icons[index],
                      width: 18,
                      height: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      placeNames[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

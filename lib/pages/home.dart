// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svce_student_management/FunctionPages/page1.dart';
import 'package:svce_student_management/FunctionPages/page3.dart';
import 'package:svce_student_management/FunctionPages/page9.dart';
//import 'package:svce_student_management/FunctionPages/page9.dart';
import 'package:svce_student_management/MorePages/internalMarks.dart';
import 'package:svce_student_management/MorePages/profile.dart';
import 'package:svce_student_management/pages/Connector.dart';
import 'package:svce_student_management/pages/more_profile.dart';

const Color primaryBlue = Color(0xFF1D4ED8);
const Color secondaryGray = Color(0xFFF1F5F9);
const Color accentGreen = Color(0xFF10B981);
const Color darkText = Color(0xFF111827);
const Color black = Color.fromARGB(255, 0, 0, 0);

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: newAppBar(),
        bottomNavigationBar: BottomNavBarExample(),
      ),
    );
  }
}

AppBar newAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 70,
    backgroundColor: Colors.blue,
    title: Text("SVCE Hub"),
    titleTextStyle: TextStyle(fontFamily: "Acme", fontSize: 25),
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right:20),
        child: GestureDetector(
          onTap: (){
            Get.to(Page9());
          },
          child:Icon(
            Icons.menu_book,
            size: 35,
          ),
        ),
      ),
    ],
  );
}

class BottomNavBarExample extends StatefulWidget {
  const BottomNavBarExample({super.key});

  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  final List<Widget> pages = [
    ConnectorWidget(),
    //Hostel(),
    //ERP(),
    PersonalDetailsPage(),
  ];
  int _selectedIndex = 0;
  int selecteddummyIndex = 0;
  final bool _isBottomSheetOpen = false;

  void _onItemTapped(int index) {
    if (index == 1) {
      if (!_isBottomSheetOpen) {
        showCustomBottomSheet(context);
      }
    } else {
      setState(() {
        if (index > 0) {
          selecteddummyIndex =index - 1;
          _selectedIndex = index;
        } else {
          selecteddummyIndex = index;
          _selectedIndex = index;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBar(),
      body: pages[selecteddummyIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 115, 181, 253),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0 ? Colors.purple : Colors.black),
            label: 'Academics',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.hotel,
          //       color: _selectedIndex == 1 ? Colors.purple : Colors.black),
          //   label: 'Hostel',
          // ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.yellow),
            ),
            label: 'More',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.map,
          //       color: _selectedIndex == 3 ? Colors.purple : Colors.black),
          //   label: 'Map',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,
                color: _selectedIndex == 2 ? Colors.purple : Colors.black),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 12, color: Colors.purple),
        unselectedLabelStyle:
            const TextStyle(fontSize: 12, color: Colors.black),
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}

bool _isBottomSheetOpen = false;

void showCustomBottomSheet(BuildContext context) async {
  if (_isBottomSheetOpen) return;
  _isBottomSheetOpen = true;
  await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          // color: const Color.fromARGB(255, 244, 233, 218),
        ),
        child: ListView(
          // physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MarksCalculator()),
                );
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                      colors: const [Colors.blue, Colors.purple]),
                ),
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Center(
                  child: const Text(
                    'Internal Marks Calculator',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: "Arvo",
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => Page1());
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient:
                      LinearGradient(colors: const [Colors.blue, Colors.purple]),
                  //border: Border.all(color: const Color.fromARGB(255, 82, 80, 80), width: 2),
                ),
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Center(
                  child: const Text(
                    'Attendance',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Arvo",
                      //fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => Page3());
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient:
                      LinearGradient(colors: const [Colors.blue, Colors.purple]),
                  //border: Border.all(color: const Color.fromARGB(255, 82, 80, 80), width: 2),
                ),
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Center(
                  child: const Text(
                    'Result',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Arvo",
                      //fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => BottomPersonalDetailsPage());
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                      colors: const [Colors.blue, Colors.purple]),
                  //border: Border.all(color: const Color.fromARGB(255, 82, 80, 80), width: 2),
                ),
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Center(
                  child: const Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Arvo",
                      //fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text(
                'Close',
                style: TextStyle(
                  color: Colors.black
                ),
                ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
  _isBottomSheetOpen = false;
}

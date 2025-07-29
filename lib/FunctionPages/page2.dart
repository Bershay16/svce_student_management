// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_import

import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String selectedDay = 'Monday';

  // Example schedules for each day
  final Map<String, List<ScheduleCard>> schedules = {
    'Monday': [
      ScheduleCard(
        time: '08:30 AM-09:20 AM',
        courseName: 'Discrete Mathematics',
        courseCode: 'MA22353',
        section: 'A',
      ),
      ScheduleCard(
        time: '09:20 AM-10:10 AM',
        courseName: 'Data Structures and Algorithms',
        courseCode: 'IT22301',
        section: 'A',
      ),
      ScheduleCard(
        time: '10:25 AM-11:15 AM',
        courseName: 'Database Concepts',
        courseCode: 'IT22302',
        section: 'A',
      ),
      ScheduleCard(
        time: '11:15 AM-12:05 PM',
        courseName: 'Digital Communication',
        courseCode: 'IT22303',
        section: 'A',
      ),
      ScheduleCard(
        time: '12:45 PM-01:35 PM',
        courseName: 'IT Essentials: Theory and Practices',
        courseCode: 'IT22309',
        section: 'A',
      ),
      ScheduleCard(
        time: '01:35 PM-02:25 PM',
        courseName: 'Data Structures and Algorithms Laboratory',
        courseCode: 'IT22311',
        section: 'A',
      ),
      ScheduleCard(
        time: '02:25 PM-03:15 PM',
        courseName: 'Database Concepts Laboratory',
        courseCode: 'IT22312',
        section: 'A',
      ),
    ],
    'Tuesday': [
      ScheduleCard(
        time: '08:30 AM-09:20 AM',
        courseName: 'Digital Communication Laboratory',
        courseCode: 'IT22313',
        section: 'A',
      ),
      ScheduleCard(
        time: '09:20 AM-10:10 AM',
        courseName: 'Discrete Mathematics',
        courseCode: 'MA22353',
        section: 'A',
      ),
      ScheduleCard(
        time: '10:25 AM-11:15 AM',
        courseName: 'Seminar',
        courseCode: 'SEM',
        section: 'A',
      ),
      ScheduleCard(
        time: '11:15 AM-12:05 PM',
        courseName: 'Placement and Training',
        courseCode: 'PT',
        section: 'A',
      ),
      ScheduleCard(
        time: '12:45 PM-01:35 PM',
        courseName: 'Library',
        courseCode: 'LIB',
        section: 'A',
      ),
      ScheduleCard(
        time: '01:35 PM-02:25 PM',
        courseName: 'Data Structures and Algorithms',
        courseCode: 'IT22301',
        section: 'A',
      ),
      ScheduleCard(
        time: '02:25 PM-03:15 PM',
        courseName: 'Database Concepts',
        courseCode: 'IT22302',
        section: 'A',
      ),
    ],
    // Additional days can be filled similarly
    'Wednesday': [
      ScheduleCard(
        time: '08:30 AM-09:20 AM',
        courseName: 'Database Concepts',
        courseCode: 'IT22302',
        section: 'A',
      ),
      ScheduleCard(
        time: '09:20 AM-10:10 AM',
        courseName: 'Digital Communication',
        courseCode: 'IT22303',
        section: 'A',
      ),
      ScheduleCard(
        time: '10:25 AM-11:15 AM',
        courseName: 'IT Essentials: Theory and Practices',
        courseCode: 'IT22309',
        section: 'A',
      ),
      ScheduleCard(
        time: '11:15 AM-12:05 PM',
        courseName: 'Database Concepts Laboratory',
        courseCode: 'IT22312',
        section: 'A',
      ),
      ScheduleCard(
        time: '12:45 PM-01:35 PM',
        courseName: 'Digital Communication Laboratory',
        courseCode: 'IT22313',
        section: 'A',
      ),
      ScheduleCard(
        time: '01:35 PM-02:25 PM',
        courseName: 'Discrete Mathematics',
        courseCode: 'MA22353',
        section: 'A',
      ),
      ScheduleCard(
        time: '02:25 PM-03:15 PM',
        courseName: 'Placement and Training',
        courseCode: 'PT',
        section: 'A',
      ),
    ],
    'Thursday': [
      ScheduleCard(
        time: '08:30 AM-09:20 AM',
        courseName: 'Data Structures and Algorithms',
        courseCode: 'IT22301',
        section: 'A',
      ),
      ScheduleCard(
        time: '09:20 AM-10:10 AM',
        courseName: 'Library',
        courseCode: 'LIB',
        section: 'A',
      ),
      ScheduleCard(
        time: '10:25 AM-11:15 AM',
        courseName: 'Seminar',
        courseCode: 'SEM',
        section: 'A',
      ),
      ScheduleCard(
        time: '11:15 AM-12:05 PM',
        courseName: 'Data Structures and Algorithms Laboratory',
        courseCode: 'IT22311',
        section: 'A',
      ),
      ScheduleCard(
        time: '12:45 PM-01:35 PM',
        courseName: 'Database Concepts',
        courseCode: 'IT22302',
        section: 'A',
      ),
      ScheduleCard(
        time: '01:35 PM-02:25 PM',
        courseName: 'Digital Communication',
        courseCode: 'IT22303',
        section: 'A',
      ),
      ScheduleCard(
        time: '02:25 PM-03:15 PM',
        courseName: 'IT Essentials: Theory and Practices',
        courseCode: 'IT22309',
        section: 'A',
      ),
    ],
    'Friday': [
      ScheduleCard(
        time: '08:30 AM-09:20 AM',
        courseName: 'Digital Communication Laboratory',
        courseCode: 'IT22313',
        section: 'A',
      ),
      ScheduleCard(
        time: '09:20 AM-10:10 AM',
        courseName: 'Data Structures and Algorithms',
        courseCode: 'IT22301',
        section: 'A',
      ),
      ScheduleCard(
        time: '10:25 AM-11:15 AM',
        courseName: 'Discrete Mathematics',
        courseCode: 'MA22353',
        section: 'A',
      ),
      ScheduleCard(
        time: '11:15 AM-12:05 PM',
        courseName: 'Placement and Training',
        courseCode: 'PT',
        section: 'A',
      ),
      ScheduleCard(
        time: '12:45 PM-01:35 PM',
        courseName: 'Database Concepts Laboratory',
        courseCode: 'IT22312',
        section: 'A',
      ),
      ScheduleCard(
        time: '01:35 PM-02:25 PM',
        courseName: 'Digital Communication',
        courseCode: 'IT22303',
        section: 'A',
      ),
      ScheduleCard(
        time: '02:25 PM-03:15 PM',
        courseName: 'IT Essentials: Theory and Practices',
        courseCode: 'IT22309',
        section: 'A',
      ),
    ],
    'Saturday': [
      ScheduleCard(
        time: '08:30 AM-09:20 AM',
        courseName: 'Library',
        courseCode: 'LIB',
        section: 'A',
      ),
      ScheduleCard(
        time: '09:20 AM-10:10 AM',
        courseName: 'Seminar',
        courseCode: 'SEM',
        section: 'A',
      ),
      ScheduleCard(
        time: '10:25 AM-11:15 AM',
        courseName: 'Data Structures and Algorithms Laboratory',
        courseCode: 'IT22311',
        section: 'A',
      ),
      ScheduleCard(
        time: '11:15 AM-12:05 PM',
        courseName: 'Database Concepts',
        courseCode: 'IT22302',
        section: 'A',
      ),
      ScheduleCard(
        time: '12:45 PM-01:35 PM',
        courseName: 'Digital Communication',
        courseCode: 'IT22303',
        section: 'A',
      ),
      ScheduleCard(
        time: '01:35 PM-02:25 PM',
        courseName: 'Discrete Mathematics',
        courseCode: 'MA22353',
        section: 'A',
      ),
      ScheduleCard(
        time: '02:25 PM-03:15 PM',
        courseName: 'Data Structures and Algorithms',
        courseCode: 'IT22301',
        section: 'A',
      ),
    ],
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Schedule'),
        centerTitle: true,
        
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                value: selectedDay,
                onChanged: (newDay) {
                  setState(() {
                    selectedDay = newDay!;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                ].map((day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(10),
                children: schedules[selectedDay]!.isNotEmpty
                    ? schedules[selectedDay]!
                    : [
                        Center(
                          child: Text(
                            'No classes scheduled for $selectedDay.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
}

class ScheduleCard extends StatelessWidget {
  final String time;
  final String courseName;
  final String courseCode;
  final String section;

  const ScheduleCard({super.key, 
    required this.time,
    required this.courseName,
    required this.courseCode,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Lecture',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.timer, color: Colors.white),
              SizedBox(width: 5),
              Text(
                time,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          DetailRow(label: 'Course Name', value: courseName),
          DetailRow(label: 'Course Code', value: courseCode),
          DetailRow(label: 'Section', value: section),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label : ',
              style: TextStyle(
                color: Colors.lightBlue[100],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

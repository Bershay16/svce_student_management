import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Page1 extends StatelessWidget {
  final List<Map<String, dynamic>> subjects = [
    {
      'code': 'MA22353',
      'name': 'Discrete Mathematics (Common to CS & IT)',
      'total': 50,
      'present': 45,
      'absent': 5,
      'faculty': 'Dr. Rajan M',
    },
    {
      'code': 'IT22301',
      'name': 'Data Structures and Algorithms',
      'total': 45,
      'present': 40,
      'absent': 5,
      'faculty': 'Prof. Stephen P',
    },
    {
      'code': 'IT22302',
      'name': 'Database Concepts',
      'total': 48,
      'present': 44,
      'absent': 4,
      'faculty': 'Prof. Suresh E',
    },
    {
      'code': 'IT22303',
      'name': 'Digital Communication',
      'total': 52,
      'present': 43,
      'absent': 9,
      'faculty': 'Ram Prakash C',
    },
    {
      'code': 'IT22309',
      'name': 'IT Essentials: Theory and Practices',
      'total': 40,
      'present': 37,
      'absent': 3,
      'faculty': 'Anand B',
    },
    {
      'code': 'IT22311',
      'name': 'Data Structures and Algorithms Laboratory',
      'total': 36,
      'present': 33,
      'absent': 3,
      'faculty': 'P. Sivaranjani',
    },
    {
      'code': 'IT22312',
      'name': 'Database Concepts Laboratory',
      'total': 30,
      'present': 28,
      'absent': 2,
      'faculty': 'K. Mahesh',
    },
    {
      'code': 'IT22313',
      'name': 'Digital Communication Laboratory',
      'total': 25,
      'present': 20,
      'absent': 5,
      'faculty': 'N. Suresh',
    },
  ];

  Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Attendance', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            return SubjectCard(subject: subjects[index]);
          },
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final Map<String, dynamic> subject;

  const SubjectCard({super.key, required this.subject});

  double getAttendancePercentage() {
    return (subject['present'] / subject['total']) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${subject['code']} - ${subject['name']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 6.0,
                  animation: true,
                  percent: getAttendancePercentage() / 100,
                  center: Text(
                    "${getAttendancePercentage().toStringAsFixed(0)}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: getAttendancePercentage() >= 75
                      ? Colors.green
                      : Colors.red,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Total', subject['total'].toString()),
                    _buildInfoRow('Present', subject['present'].toString()),
                    _buildInfoRow('Absent', subject['absent'].toString()),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[700],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Faculty: ${subject['faculty']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue[700],
            ),
          ),
          Text(value, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}

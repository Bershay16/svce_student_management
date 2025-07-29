import 'package:flutter/material.dart';

class PersonalDetailsPage extends StatelessWidget {
  final List<Map<String, String>> students = [
    {
      'Enrollment No': '2023110079',
      'Student Name': 'New User R',
      'Degree': 'B.Tech.',
      'Branch': 'Information Technology',
      'Semester': '03',
      'Father\'s Name': 'Christiano Ronaldo N',
      'Mother\'s Name': 'Georgina T',
      'Gender': 'Male',
      'DOB': '16-02-2006',
      'Height': '',
      'Weight': '',
      'Identity Mark': '',
      'Caste': 'NADAR',
      'Category': 'BC',
      'Blood Group': 'B+',
    },
  ];

  PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 80,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Student Information',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          fontFamily: "Alatsi"),
                    ),
                  ),
                  SizedBox(height: 20),
                  ...student.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Text(
                            '${entry.key}:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              entry.value.isNotEmpty ? entry.value : 'N/A',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

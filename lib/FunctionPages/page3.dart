import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  final String studentName = "New User R";
  final String regNo = "2127230801016";
  final String degree = "B.Tech.";
  final String branch = "Information Technology";

  final List<Map<String, String>> subjects = [
    {"subject": "Biology for Engineers(BT22101)", "grade": "A", "result": "P"},
    {
      "subject": "Science and Technology in Ancient Tamil Society(HS22251)",
      "grade": "A",
      "result": "P"
    },
    {"subject": "Technical English(HS22252)", "grade": "A", "result": "P"},
    {
      "subject": "Computer Organization and Architecture(IT22201)",
      "grade": "B+",
      "result": "P"
    },
    {
      "subject": "OOPS using C++ and Python(IT22202)",
      "grade": "A",
      "result": "P"
    },
    {"subject": "Applied Mathematics II(MA22251)", "grade": "A", "result": "P"},
    {"subject": "Technical Drawing(ME22251)", "grade": "A", "result": "P"},
    {
      "subject": "Hardware Assembling and Software Tools Laboratory(IT22211)",
      "grade": "A+",
      "result": "P"
    },
    {
      "subject": "OOPS using C++ and Python Laboratory(IT22212)",
      "grade": "A",
      "result": "P"
    },
  ];

  Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            SizedBox(height: 20),
            _buildResultTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            studentName,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          SizedBox(height: 10),
          _buildProfileRow("Registration No", regNo),
          _buildProfileRow("Degree", degree),
          _buildProfileRow("Branch", branch),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text("$label: ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 14)),
          Text(value, style: TextStyle(color: Colors.black, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildResultTable() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: Offset(2, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTableHeader(),
            Divider(thickness: 1),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return _buildTableRow(subjects[index], index.isEven);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text("Subject",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 14))),
          Text("Grade",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 10)),
          Text("Result",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildTableRow(Map<String, String> subjectData, bool isEven) {
    return Container(
      color: isEven ? Colors.grey.shade100 : Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              subjectData["subject"]!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12), // Reduced font size for subjects
            ),
          ),
          Text(
            subjectData["grade"]!,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(width: 16), // Added spacing between grade and result
          Text(
            subjectData["result"]!,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';


class Page4 extends StatelessWidget {
  final subjects = [
    {
      "code": "MA22353",
      "name": "Discrete Mathematics (Common to CS & IT)",
      "marks": {
        "CAT-1": 42,
        "CAT-2": 38,
        "CAT-3": 40,
        "Assignment-1": 45,
        "Assignment-2": 48,
        "Assignment-3": 46,
      }
    },
    {
      "code": "IT22301",
      "name": "Data Structures and Algorithms",
      "marks": {
        "CAT-1": 45,
        "CAT-2": 48,
        "CAT-3": 50,
        "Assignment-1": 40,
        "Assignment-2": 42,
        "Assignment-3": 41,
      }
    },
    {
      "code": "IT22302",
      "name": "Database Concepts",
      "marks": {
        "CAT-1": 36,
        "CAT-2": 50,
        "CAT-3": 44,
        "Assignment-1": 42,
        "Assignment-2": 45,
        "Assignment-3": 43,
      }
    },
    {
      "code": "IT22303",
      "name": "Digital Communication",
      "marks": {
        "CAT-1": 40,
        "CAT-2": 35,
        "CAT-3": 39,
        "Assignment-1": 38,
        "Assignment-2": 37,
        "Assignment-3": 41,
      }
    },
    {
      "code": "IT22309",
      "name": "IT Essentials: Theory and Practices",
      "marks": {
        "CAT-1": 50,
        "CAT-2": 52,
        "CAT-3": 49,
        "Assignment-1": 45,
        "Assignment-2": 48,
        "Assignment-3": 46,
      }
    },
    {
      "code": "IT22311",
      "name": "Data Structures and Algorithms Laboratory",
      "marks": {
        "CAT-1": 48,
        "CAT-2": 49,
        "CAT-3": 51,
        "Assignment-1": 47,
        "Assignment-2": 44,
        "Assignment-3": 42,
      }
    },
    {
      "code": "IT22312",
      "name": "Database Concepts Laboratory",
      "marks": {
        "CAT-1": 43,
        "CAT-2": 40,
        "CAT-3": 45,
        "Assignment-1": 41,
        "Assignment-2": 39,
        "Assignment-3": 42,
      }
    },
    {
      "code": "IT22313",
      "name": "Digital Communication Laboratory",
      "marks": {
        "CAT-1": 44,
        "CAT-2": 46,
        "CAT-3": 47,
        "Assignment-1": 39,
        "Assignment-2": 37,
        "Assignment-3": 38,
      }
    },
  ];

  Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internal Marks'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return SubjectCard(subject: subjects[index]);
        },
      ),
    );
  }
}

class SubjectCard extends StatefulWidget {
  final Map<String, dynamic> subject;

  const SubjectCard({super.key, required this.subject});

  @override
  _SubjectCardState createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  final bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(2, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.subject["name"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(widget.subject["code"], style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold)),
            if (_isExpanded) ...[
              SizedBox(height: 10),
              _buildMarksTable(widget.subject["marks"]),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildMarksTable(Map<String, dynamic> marks) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          children: [
            TableRow(
              children: [
                Text("CAT-1", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("CAT-2", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("CAT-3", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            TableRow(
              children: [
                Text(marks["CAT-1"].toString()),
                Text(marks["CAT-2"].toString()),
                Text(marks["CAT-3"].toString()),
              ],
            ),
            TableRow(
              children: [
                Text("Assign-1", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Assign-2", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Assign-3", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            TableRow(
              children: [
                Text(marks["Assignment-1"].toString()),
                Text(marks["Assignment-2"].toString()),
                Text(marks["Assignment-3"].toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

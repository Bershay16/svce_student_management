// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_import

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Page7 extends StatefulWidget {
  const Page7({super.key});

  @override
  _Page7State createState() => _Page7State();
}

class _Page7State extends State<Page7> {
  final List<Map<String, dynamic>> grievances = [];

  @override
  void initState() {
    super.initState();
    _loadGrievances();
  }

  // Load grievances from SharedPreferences
  Future<void> _loadGrievances() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? grievancesData = prefs.getString('grievances');
    if (grievancesData != null) {
      setState(() {
        grievances.addAll(List<Map<String, dynamic>>.from(json.decode(grievancesData)));
      });
    }
  }

  // Save grievances to SharedPreferences
  Future<void> _saveGrievances() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('grievances', json.encode(grievances));
  }

  void _showGrievanceDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController regNumController = TextEditingController();
    final TextEditingController grievanceController = TextEditingController();
    final TextEditingController contactController = TextEditingController();
    String priority = "Normal";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Grievance'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: regNumController,
                  decoration: InputDecoration(
                    labelText: 'Registration Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: grievanceController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Grievance',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: contactController,
                  decoration: InputDecoration(
                    labelText: 'Contact Information (Optional)',
                    hintText: 'Email or Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: priority,
                  items: ['Low', 'Normal', 'High']
                      .map((level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ))
                      .toList(),
                  decoration: InputDecoration(
                    labelText: 'Priority Level',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      priority = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    regNumController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Required Fields!"),
                          content: Text(
                              "Name and Registration numbers are required."),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Ok"))
                          ],
                        );
                      });
                  return;
                }
                setState(() {
                  grievances.add({
                    'name': nameController.text,
                    'registration': regNumController.text,
                    'grievance': grievanceController.text,
                    'contact': contactController.text,
                    'priority': priority,
                  });
                  _saveGrievances(); // Save data after adding a new grievance
                });
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Grievance Redressal'),
      ),
      body: Container(
        color: Colors.blue[100],
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: grievances.length,
          itemBuilder: (context, index) {
            final grievance = grievances[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  grievance['name'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Registration: ${grievance['registration']}'),
                    Text('Grievance: ${grievance['grievance']}'),
                    if (grievance['contact'] != null && grievance['contact']!.isNotEmpty)
                      Text('Contact: ${grievance['contact']}'),
                    Text('Priority: ${grievance['priority']}'),
                  ],
                ),
                trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        grievances.removeAt(index);
                        _saveGrievances(); // Save data after removing a grievance
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showGrievanceDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

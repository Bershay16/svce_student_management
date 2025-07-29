import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PCD extends StatefulWidget {
  const PCD({super.key});

  @override
  _PCDState createState() => _PCDState();
}

class _PCDState extends State<PCD> {
  final List<Map<String, dynamic>> _requests = [];
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('requests');
    if (data != null) {
      setState(() {
        _requests.addAll(List<Map<String, dynamic>>.from(json.decode(data)));
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('requests', json.encode(_requests));
  }

  int _calculateApprovedHours() {
    return _requests
        .where((request) => request['status'] == 'Approved')
        .fold(0, (sum, request) => sum + (request['hours'] as int));
  }


  void _openRequestModal() {
    String requestText = '';
    DateTime? selectedDate;
    int hours = 1;
    File? selectedImage;

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 16.0, bottom: 16 + 16),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'PCD Form',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Event Name',
                        hintText: '(max 100 chars)',
                        border: OutlineInputBorder(),
                      ),
                      maxLength: 100,
                      onChanged: (value) {
                        requestText = value;
                      },
                    ),
                    SizedBox(height: 8),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Event Date',
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        setModalState(() {});
                      },
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Hours',
                        border: OutlineInputBorder(),
                      ),
                      value: hours,
                      items: List.generate(8, (index) {
                        return DropdownMenuItem(
                          value: index + 1,
                          child: Text('${index + 1} hours'),
                        );
                      }),
                      onChanged: (value) {
                        hours = value!;
                      },
                    ),
                    SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () async {
                        final pickedFile = await _imagePicker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          setModalState(() {
                            selectedImage = File(pickedFile.path);
                          });
                        }
                      },
                      icon: Icon(Icons.image),
                      label: Text('Upload Image'),
                    ),
                    if (selectedImage != null)
                      Image.file(selectedImage!, height: 100, fit: BoxFit.cover),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (requestText.isNotEmpty &&
                            selectedDate != null &&
                            selectedImage != null) {
                          setState(() {
                            _requests.add({
                              'text': requestText,
                              'date': selectedDate!.toIso8601String(),
                              'hours': hours,
                              'image': selectedImage!.path,
                              'status': 'Pending',
                            });
                          });
                          _saveData();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.black
                        ),
                        
                        ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showImagePreview(String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(File(imagePath)),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final approvedHours = _calculateApprovedHours();

    return Scaffold(
      appBar: AppBar(
        title: Text("PCD"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent.shade700, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (approvedHours > 0)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Center(
                  child: Text(
                    'Total Approved Hours: $approvedHours',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _requests.length,
                itemBuilder: (context, index) {
                  final request = _requests[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          if (request['image'] != null) {
                            _showImagePreview(request['image']);
                          }
                        },
                        child: request['image'] != null
                            ? Image.file(
                                File(request['image']),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.image),
                      ),
                      title: Text(request['text']),
                      subtitle: Text(
                          'Date: ${request['date'].split('T')[0]}\nHours: ${request['hours']}'),
                      trailing: Text(
                        request['status'],
                        style: TextStyle(
                          color: request['status'] == 'Pending'
                              ? Colors.orange
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        if (request['status'] == 'Pending') {
                          setState(() {
                            _requests[index]['status'] = 'Approved';
                          });
                          _saveData();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openRequestModal,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
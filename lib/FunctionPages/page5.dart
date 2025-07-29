import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  List<LeaveApplication> _applications = [];
  static const int maxApplications = 5;

  @override
  void initState() {
    super.initState();
    _loadApplications();
  }

  Future<void> _loadApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? applicationsString = prefs.getString('applications');
    if (applicationsString != null) {
      final List<dynamic> jsonData = jsonDecode(applicationsString);
      setState(() {
        _applications =
            jsonData.map((json) => LeaveApplication.fromJson(json)).toList();
      });
    }
  }

  Future<void> _saveApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final String applicationsString =
        jsonEncode(_applications.map((app) => app.toJson()).toList());
    await prefs.setString('applications', applicationsString);
  }

  void _openApplyForm(BuildContext context, {LeaveApplication? application}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ApplyForm(
        onSubmit: (newApplication) {
          setState(() {
            if (application == null) {
              _applications.add(newApplication);
            } else {
              final index = _applications.indexOf(application);
              _applications[index] = newApplication;
            }
          });
          _saveApplications();
          Navigator.of(context).pop();
        },
        existingApplication: application,
      ),
    );
  }

  void _deleteApplication(int index) {
    setState(() {
      _applications.removeAt(index);
    });
    _saveApplications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OD Forms"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: _applications.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 300),
                child: Text("No applications submitted yet."),
              ),
            )
          : ListView.builder(
              itemCount: _applications.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Session: ${_applications[index].session}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Leave Type: ${_applications[index].leaveType}"),
                        Text("From: ${_applications[index].fromDate}"),
                        Text("To: ${_applications[index].toDate}"),
                        Text("Reason: ${_applications[index].reason}"),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => _openApplyForm(context,
                                  application: _applications[index]),
                              child: const Text(
                                "Edit",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () => _deleteApplication(index),
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openApplyForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Model class for LeaveApplication
class LeaveApplication {
  final String session;
  final String leaveType;
  final String fromDate;
  final String toDate;
  final String reason;

  LeaveApplication({
    required this.session,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.reason,
  });

  Map<String, dynamic> toJson() => {
        'session': session,
        'leaveType': leaveType,
        'fromDate': fromDate,
        'toDate': toDate,
        'reason': reason,
      };

  factory LeaveApplication.fromJson(Map<String, dynamic> json) {
    return LeaveApplication(
      session: json['session'],
      leaveType: json['leaveType'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      reason: json['reason'],
    );
  }
}

class ApplyForm extends StatefulWidget {
  final Function(LeaveApplication) onSubmit;
  final LeaveApplication? existingApplication;

  const ApplyForm({
    super.key,
    required this.onSubmit,
    this.existingApplication,
  });

  @override
  _ApplyFormState createState() => _ApplyFormState();
}

class _ApplyFormState extends State<ApplyForm> {
  final _formKey = GlobalKey<FormState>();
  late String _session;
  late String _leaveType;
  DateTime? _fromDate;
  DateTime? _toDate;
  String _reason = '';

  @override
  void initState() {
    super.initState();
    if (widget.existingApplication != null) {
      final app = widget.existingApplication!;
      _session = app.session;
      _leaveType = app.leaveType;
      _fromDate = DateTime.tryParse(app.fromDate);
      _toDate = DateTime.tryParse(app.toDate);
      _reason = app.reason;
    } else {
      _session = '2024-2025';
      _leaveType = 'Normal';
    }
  }

  Future<void> _pickDate(BuildContext context, bool isFromDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      widget.onSubmit(LeaveApplication(
        session: _session,
        leaveType: _leaveType,
        fromDate: _fromDate?.toIso8601String() ?? 'Not selected',
        toDate: _toDate?.toIso8601String() ?? 'Not selected',
        reason: _reason,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(///////////////////////////////////////////////////////////////////
                child: Text(
                  'Apply for Leave',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Text('Session', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _session,
                items: ['2024-2025', '2025-2026'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) => setState(() => _session = newValue!),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              Text('Leave Type', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _leaveType,
                items: ['Normal', 'Medical', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) => setState(() => _leaveType = newValue!),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From Date', style: TextStyle(fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () => _pickDate(context, true),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _fromDate == null
                                  ? 'Select Date'
                                  : '${_fromDate!.day}/${_fromDate!.month}/${_fromDate!.year}',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('To Date', style: TextStyle(fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () => _pickDate(context, false),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _toDate == null
                                  ? 'Select Date'
                                  : '${_toDate!.day}/${_toDate!.month}/${_toDate!.year}',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Reason', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Write reason here',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _reason = value ?? '',
                initialValue: _reason, // Set the initial value for editing
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.black
                    ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

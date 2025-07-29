import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For jsonEncode and jsonDecode

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  List<LeaveApplication> _applications = [];
  static const int maxApplications = 5;
  int remainingApplications = maxApplications;

  @override
  void initState() {
    super.initState();
    _loadApplications(); // Load applications on initialization
  }

  // Load saved applications from Shared Preferences
  Future<void> _loadApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? applicationsString = prefs.getString('applications');
    if (applicationsString != null) {
      final List<dynamic> jsonData = jsonDecode(applicationsString);
      setState(() {
        _applications = jsonData.map((json) => LeaveApplication.fromJson(json)).toList();
        remainingApplications = maxApplications - _applications.length; // Update remaining limit
      });
    }
  }

  // Save applications to Shared Preferences
  Future<void> _saveApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final String applicationsString = jsonEncode(_applications.map((app) => app.toJson()).toList());
    prefs.setString('applications', applicationsString);
  }

  void _openApplyForm(BuildContext context, {LeaveApplication? application}) {
    if (_applications.length >= maxApplications) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You can only apply for up to $maxApplications OD applications.')));
      return;
    }

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
              // Add new application
              _applications.add(newApplication);
            } else {
              // Update existing application
              final index = _applications.indexOf(application);
              _applications[index] = newApplication;
            }
            remainingApplications = maxApplications - _applications.length; // Update remaining applications
          });
          _saveApplications(); // Save applications after adding or updating
          Navigator.of(context).pop();
        },
        existingApplication: application, // Pass existing application for editing
      ),
    );
  }

  void _deleteApplication(int index) {
    setState(() {
      _applications.removeAt(index); // Remove application
      remainingApplications = maxApplications - _applications.length; // Update remaining applications
    });
    _saveApplications(); // Update saved applications
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OD Form\'s'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[100],
            child: Text(
              'Remaining OD Applications: $remainingApplications',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _applications.isEmpty
                ? Center(child: Text('No applications submitted yet.'))
                : ListView.builder(
                    itemCount: _applications.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Session: ${_applications[index].session}', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('Leave Type: ${_applications[index].leaveType}'),
                              Text('From: ${_applications[index].fromDate}'),
                              Text('To: ${_applications[index].toDate}'),
                              Text('Reason: ${_applications[index].reason}'),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => _openApplyForm(context, application: _applications[index]), // Edit
                                    child: Text('Edit', style: TextStyle(color: Colors.blue)),
                                  ),
                                  SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () => _deleteApplication(index), // Delete
                                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openApplyForm(context), // Open form to add new application
        child: Icon(Icons.add),
      ),
    );
  }
}

// Model class for Leave Application
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

  // Convert a LeaveApplication instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'session': session,
      'leaveType': leaveType,
      'fromDate': fromDate,
      'toDate': toDate,
      'reason': reason,
    };
  }

  // Create a LeaveApplication instance from a Map
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
  final LeaveApplication? existingApplication; // Optional existing application for editing

  const ApplyForm({super.key, required this.onSubmit, this.existingApplication});

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
      // If editing, pre-fill the form fields with existing application data
      _session = widget.existingApplication!.session;
      _leaveType = widget.existingApplication!.leaveType;

      // Check if dates are 'Not selected' before parsing
      _fromDate = widget.existingApplication!.fromDate != 'Not selected'
          ? DateTime.parse(widget.existingApplication!.fromDate)
          : null; // Set to null if not selected

      _toDate = widget.existingApplication!.toDate != 'Not selected'
          ? DateTime.parse(widget.existingApplication!.toDate)
          : null; // Set to null if not selected

      _reason = widget.existingApplication!.reason;
    } else {
      // Default values for new application
      _session = '2024-2025';
      _leaveType = 'Normal';
    }
  }

  Future<void> _pickDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
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
      LeaveApplication application = LeaveApplication(
        session: _session,
        leaveType: _leaveType,
        fromDate: _fromDate != null ? _fromDate!.toIso8601String() : 'Not selected', // Save as ISO string
        toDate: _toDate != null ? _toDate!.toIso8601String() : 'Not selected', // Save as ISO string
        reason: _reason,
      );

      widget.onSubmit(application);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Apply for Leave',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _session,
                decoration: InputDecoration(labelText: 'Session'),
                onSaved: (value) => _session = value ?? '',
                validator: (value) => value?.isEmpty ?? true ? 'Please enter session' : null,
              ),
              TextFormField(
                initialValue: _leaveType,
                decoration: InputDecoration(labelText: 'Leave Type'),
                onSaved: (value) => _leaveType = value ?? '',
                validator: (value) => value?.isEmpty ?? true ? 'Please enter leave type' : null,
              ),
              Row(
                children: [
                  Text(
                    _fromDate == null ? 'From Date: Not selected' : 'From Date: ${_fromDate!.toLocal()}',
                  ),
                  TextButton(
                    onPressed: () => _pickDate(context, true),
                    child: Text('Pick Date'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    _toDate == null ? 'To Date: Not selected' : 'To Date: ${_toDate!.toLocal()}',
                  ),
                  TextButton(
                    onPressed: () => _pickDate(context, false),
                    child: Text('Pick Date'),
                  ),
                ],
              ),
              TextFormField(
                initialValue: _reason,
                decoration: InputDecoration(labelText: 'Reason'),
                onSaved: (value) => _reason = value ?? '',
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a reason' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

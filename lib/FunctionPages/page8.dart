import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Page8 extends StatefulWidget {
  const Page8({super.key});

  @override
  _Page8State createState() => _Page8State();
}

class _Page8State extends State<Page8> {
  final List<Map<String, String>> announcements = [];
  final TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredAnnouncements = [];

  @override
  void initState() {
    super.initState();
    _loadAnnouncements();
    filteredAnnouncements = announcements;
  }

  Future<void> _loadAnnouncements() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedAnnouncements = prefs.getString('announcements');
    if (savedAnnouncements != null) {
      try {
        // Decode JSON and cast to List<Map<String, String>>
        final List<dynamic> jsonList = json.decode(savedAnnouncements);
        setState(() {
          announcements.addAll(
            jsonList.map((item) => Map<String, String>.from(item)).toList(),
          );
          filteredAnnouncements = List.from(announcements);
        });
        debugPrint("Announcements loaded successfully.");
      } catch (e) {
        debugPrint("Failed to load announcements: $e");
      }
    } else {
      debugPrint("No saved announcements found.");
    }
  }

  Future<void> _saveAnnouncements() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // Encode the announcements and save them
      await prefs.setString('announcements', json.encode(announcements));
      debugPrint("Announcements saved successfully.");
    } catch (e) {
      debugPrint("Failed to save announcements: $e");
    }
  }

  void _showAnnouncementDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String priority = "Normal";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Announcement'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: priority,
                  items: ['Low', 'Normal', 'High']
                      .map((level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ))
                      .toList(),
                  decoration: const InputDecoration(
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
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final newAnnouncement = {
                    'title': titleController.text,
                    'description': descriptionController.text,
                    'priority': priority,
                    'date': DateTime.now().toString().split(' ')[0],
                  };
                  announcements.add(newAnnouncement);
                  filteredAnnouncements = List.from(announcements);
                });
                _saveAnnouncements();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _searchAnnouncements(String query) {
    final results = announcements.where((announcement) {
      final titleLower = announcement['title']!.toLowerCase();
      final descriptionLower = announcement['description']!.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) || descriptionLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredAnnouncements = results;
    });
  }

  void _deleteAnnouncement(int index) {
    setState(() {
      announcements.removeAt(index);
      filteredAnnouncements = List.from(announcements);
    });
    _saveAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Announcements'),
      ),
      body: Container(
        color: Colors.blue[100],
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Announcements',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _searchAnnouncements,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAnnouncements.length,
                itemBuilder: (context, index) {
                  final announcement = filteredAnnouncements[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        announcement['title'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(announcement['description'] ?? ''),
                          const SizedBox(height: 5),
                          Text(
                            'Date: ${announcement['date']}',
                            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                          ),
                          Text(
                            'Priority: ${announcement['priority']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: announcement['priority'] == 'High'
                                  ? Colors.red
                                  : announcement['priority'] == 'Normal'
                                      ? Colors.orange
                                      : Colors.green,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteAnnouncement(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAnnouncementDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

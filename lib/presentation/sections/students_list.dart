import 'package:flutter/material.dart';

import '../../model/student.dart';

class StudentsList extends StatefulWidget {
  @override
  _StudentsListState createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  List<Student> students = [
    Student(name: 'Gemechis', id: "ETS1123", section: 'A', gender: 'Male'),
    Student(name: 'Habteyesus', id: "ETS1215", section: 'A', gender: 'Male'),
    Student(name: 'EtsubDink', id: "ETS1511", section: 'A', gender: 'Male'),
    Student(name: 'John Doe', id: "ETS1151", section: 'A', gender: 'Male'),
    Student(name: 'Jane Smith', id: "ETS2422", section: 'B', gender: 'Female'),
    Student(name: 'Alex Johnson', id: "ETS3516", section: 'A', gender: 'Male'),
    Student(name: 'Emily Davis', id: "ETS4262", section: 'B', gender: 'Female'),
  ];

  List<Student> filteredStudents = [
    Student(name: 'Gemechis', id: "ETS1123", section: 'A', gender: 'Male'),
    Student(name: 'Habteyesus', id: "ETS1215", section: 'A', gender: 'Male'),
    Student(name: 'EtsubDink', id: "ETS1511", section: 'A', gender: 'Male'),
    Student(name: 'John Doe', id: "ETS1151", section: 'A', gender: 'Male'),
    Student(name: 'Jane Smith', id: "ETS2422", section: 'B', gender: 'Female'),
    Student(name: 'Alex Johnson', id: "ETS3516", section: 'A', gender: 'Male'),
    Student(name: 'Emily Davis', id: "ETS4262", section: 'B', gender: 'Female'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students List'),
        // ios back arrow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchBar(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListView.builder(
          itemCount: filteredStudents.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              decoration: BoxDecoration(),
              child: ListTile(
                title: Text(filteredStudents[index].name),
                subtitle: Text('ID: ${filteredStudents[index].id}'),
                onTap: () =>
                    _showStudentDetailsDialog(context, filteredStudents[index]),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSearchBar(BuildContext context) async {
    await showSearch(
      context: context,
      delegate: StudentsSearchDelegate(),
    );
  }

  // Inside your _StudentsListState class

  void _showStudentDetailsDialog(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(student.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ID: ${student.id}'),
                Text('Section: ${student.section}'),
                Text('Gender: ${student.gender}'),
                Text('Attendance Rate: 91%'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class StudentsSearchDelegate extends SearchDelegate<void> {
  List<Student> students = [
    Student(name: 'John Doe', id: "1", section: 'A', gender: 'Male'),
    Student(name: 'Jane Smith', id: "2", section: 'B', gender: 'Female'),
    Student(name: 'Alex Johnson', id: "3", section: 'A', gender: 'Male'),
    Student(name: 'Emily Davis', id: "4", section: 'B', gender: 'Female'),
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final List<Student> results = query.isEmpty
        ? []
        : students
            .where((student) =>
                student.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(results[index].name),
            subtitle: Text('ID: ${results[index].id}'),
            onTap: () {
              // Handle item click here
            },
          ),
        );
      },
    );
  }
}

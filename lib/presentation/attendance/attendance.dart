import 'dart:developer';

import 'package:flutter/material.dart';

import '../../model/student.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

// ...

class _AttendancePageState extends State<AttendancePage> {
  // Updated attendance data
  List<Map<String, dynamic>> dailyAttendance = [
    {
      'date': '2022-01-01',
      'attendance': [
        'ETS0511/13',
        'ETS0512/13',
        'ETS0513/13',
        'ETS0514/13',
      ],
    },
    {
      'date': '2022-01-02',
      'attendance': [
        'ETS0511/13',
        'ETS0512/13',
        'ETS0513/13',
        'ETS0514/13',
      ],
    },
  ];

  List<Student> studentsList = [
    Student(
      name: 'John Doe',
      id: 'ETS0511/13',
      section: 'Section A',
      gender: 'Male',
    ),
    Student(
      name: 'Jane Smith',
      id: 'ETS0512/13',
      section: 'Section B',
      gender: 'Female',
    ),
    Student(
      name: 'Abebe Asfaw',
      id: 'ETS0513/13',
      section: 'Section A',
      gender: 'Male',
    ),
    Student(
      name: 'Kebede Asfaw',
      id: 'ETS0514/13',
      section: 'Section A',
      gender: 'Male',
    ),
    Student(
      name: 'Abel Asfaw',
      id: 'ETS0515/13', // Unique ID for Abel Asfaw
      section: 'Section A',
      gender: 'Male',
    ),
    Student(
      name: 'Abenezer Asfaw',
      id: 'ETS0516/13', // Unique ID for Abenezer Asfaw
      section: 'Section B',
      gender: 'Male',
    ),
  ];

  String selectedSection = 'Section A';
  DateTime selectedDate = DateTime(2022, 1, 1);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2022, 12, 31),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Function to submit attendance
  void _submitAttendance() {
    final Map<String, dynamic> attendanceData = dailyAttendance.firstWhere(
      (data) => data['date'] == selectedDate.toString().substring(0, 10),
      orElse: () => null as Map<String, dynamic>,
    );

    if (attendanceData.isNotEmpty) {
      attendanceData['attendance'] = studentsList
          .where((student) =>
              student.section == selectedSection && student.attendance == true)
          .map((student) => student.id)
          .toList();

      // You can print or save the attendance data as needed
      log('Attendance for ${attendanceData['date']} (${selectedSection}): ${attendanceData['attendance']}');
      log(attendanceData.toString());
    }

    // show snackbar for successful submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Attendance submitted successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: selectedSection,
                  hint: const Text('Select Section'),
                  onChanged: (value) {
                    setState(() {
                      selectedSection = value ?? 'Section A';
                    });
                  },
                  items: [
                    'Section A',
                    'Section B',
                    'Section C',
                    'Section D',
                  ].map((section) {
                    return DropdownMenuItem<String>(
                      value: section,
                      child: Text(section),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_today),
                ),
                const SizedBox(width: 8),
                Text(selectedDate.toString().substring(0, 10)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: studentsList
                  .where((student) => student.section == selectedSection)
                  .length,
              itemBuilder: (context, index) {
                final Student student = studentsList
                    .where((student) => student.section == selectedSection)
                    .elementAt(index);

                return ListTile(
                  leading: Checkbox(
                    value: student.attendance,
                    onChanged: (value) {
                      setState(() {
                        student.attendance = value ?? false;
                      });
                    },
                  ),
                  title: Text(student.name),
                  subtitle: Text(
                    '${student.section}, ID: ${student.id}',
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 71, 109, 234),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  "Submit Attendance",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  try {
                    _submitAttendance();

                    // Navigate to the next route
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ESquadDashBoard(),
                    //   ),
                    // );
                  } catch (e) {
                    // Handle error and display in SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 3),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}

// ...


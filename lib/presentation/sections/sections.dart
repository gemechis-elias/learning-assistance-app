import 'package:flutter/material.dart';

class SectionsPage extends StatefulWidget {
  const SectionsPage({Key? key}) : super(key: key);

  @override
  State<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sections',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionCard(
            sectionName: 'Section A',
            numberOfStudents: 30,
            numberOfGroups: 3,
            totalQuizzesTaken: 10,
            attendanceRate: 80,
            totalChapters: 5,
            representativeName: 'Etsub',
            onTap: () {
              // Handle tap action for Section 1
            },
          ),
          SectionCard(
            sectionName: 'Section B',
            numberOfStudents: 25,
            numberOfGroups: 2,
            totalQuizzesTaken: 8,
            attendanceRate: 90,
            totalChapters: 4,
            representativeName: 'Habitsh',
            onTap: () {
              // Handle tap action for Section 2
            },
          ),
          SectionCard(
            sectionName: 'Section C',
            numberOfStudents: 30,
            numberOfGroups: 3,
            totalQuizzesTaken: 10,
            attendanceRate: 80,
            totalChapters: 5,
            representativeName: 'Duresa',
            onTap: () {
              // Handle tap action for Section 1
            },
          ),
          SectionCard(
            sectionName: 'Section D',
            numberOfStudents: 30,
            numberOfGroups: 3,
            totalQuizzesTaken: 10,
            attendanceRate: 80,
            totalChapters: 5,
            representativeName: 'Gemechis',
            onTap: () {
              // Handle tap action for Section 1
            },
          ),
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String sectionName;
  final int numberOfStudents;
  final int numberOfGroups;
  final int totalQuizzesTaken;
  final int attendanceRate;
  final int totalChapters;
  final String representativeName;
  final VoidCallback onTap;

  const SectionCard({
    Key? key,
    required this.sectionName,
    required this.numberOfStudents,
    required this.numberOfGroups,
    required this.totalQuizzesTaken,
    required this.attendanceRate,
    required this.totalChapters,
    required this.representativeName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(59, 60, 61, 0.2),
                blurRadius: 8,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sectionName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCardInfo('Students', numberOfStudents.toString()),
                    _buildCardInfo('Groups', numberOfGroups.toString()),
                    _buildCardInfo('Quizzes  ', totalQuizzesTaken.toString()),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCardInfo('Attendance', '$attendanceRate%'),
                    _buildCardInfo('Chapters', totalChapters.toString()),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Representative: $representativeName'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

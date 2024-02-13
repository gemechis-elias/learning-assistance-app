class Student {
  final String name;
  final String id;
  final String section;
  final String gender;
  bool attendance;

  Student({
    required this.name,
    required this.id,
    required this.section,
    required this.gender,
    this.attendance = false,
  });
}

import 'dart:async';
import 'dart:convert';

import 'package:assistant_app/presentation/attendance/attendance.dart';
import 'package:flutter/material.dart';

import '../../enddrawer.dart';
import '../../model/quize.dart';
import '../quize/database.dart';
import '../quize/quize_list.dart';
import '../sections/sections.dart';
import '../sections/students_list.dart';
import 'card_widget.dart';
import 'recent_quize.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Map<String, dynamic>> data_list = [
    {
      'title': 'For Teachers',
      'image': 'assets/images/teacher.jpg',
    },
    {
      'title': 'For Students:',
      'image': 'assets/images/student.jpg',
    },
  ];

  late PageController _pageController;
  late Timer _timer;

  List<Map<String, dynamic>> quizzes = [];

  void loadQuizzes() async {
    final fetchedQuizzes = await DatabaseHelper.instance.fetchAllQuizzes();
    setState(() {
      quizzes = fetchedQuizzes;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        if (_pageController.page == 1) {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        } else {
          _pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      }
    });
    loadQuizzes();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void onDrawerItemClicked(String name) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xffF8FAFF),
        appBar: AppBar(
          backgroundColor: const Color(0xffF8FAFF),
          leading: IconButton(
            icon: const Icon(
              Icons.sort,
              color: Colors.black,
              size: 37,
            ),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: const SizedBox(
            width: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dashboard",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Color.fromARGB(232, 30, 30, 31)),
                )
              ],
            ),
          ),
          actions: const [
            Icon(
              Icons.notifications_outlined,
              color: Color.fromARGB(255, 120, 116, 134),
            ),
            SizedBox(
              width: 25,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 380,
                child: GridView.count(
                  padding: const EdgeInsets.all(10),
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CardWidget(
                          context,
                          Icons.bar_chart,
                          "Attendance",
                          "10",
                          const Color(0xffe9edfa),
                          const Color(0xff264eca), onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AttendancePage(),
                          ),
                        );
                      }),
                    ),
                    CardWidget(
                        context,
                        Icons.group,
                        "Total Sections",
                        "3",
                        const Color(0xffe9f7ef),
                        const Color(0xff26af61), onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SectionsPage(),
                        ),
                      );
                    }),
                    CardWidget(
                        context,
                        Icons.groups,
                        "Total Students",
                        "190",
                        const Color(0xfffef7e9),
                        const Color(0xfff6b612), onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentsList(),
                        ),
                      );
                    }),
                    CardWidget(
                        context,
                        Icons.alarm,
                        "Total Quiz",
                        "0",
                        const Color(0xfffde8e8),
                        const Color(0xfffa4a49), onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuizList(),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Text(
                    'Recent Quizzes',
                    style: TextStyle(
                      fontFamily: 'Urbanist-Bold',
                      color: Color.fromARGB(215, 7, 39, 15),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // SingleListCard()
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 400,
                child: ListView.builder(
                  itemCount: quizzes.length,
                  itemBuilder: (context, index) {
                    List<Question> quizQuestions = [];
                    try {
                      final questionsData =
                          json.decode(quizzes[index]['questions'].toString());
                      quizQuestions = (questionsData as List)
                          .map((q) => Question.fromJson(q))
                          .toList();
                    } catch (e) {
                      print("Error decoding questions: $e");
                    }

                    return SingleListCard(
                      id: int.parse(quizzes[index]['id'].toString()),
                      title: quizzes[index]['title'].toString(),
                      isCompleted: true,
                      description: 'This is the description of the quiz',
                      onDateSelected: (DateTime value) {},
                      createdDate: DateTime.parse(
                          quizzes[index]['createdDate'].toString()),
                      quizQuestions: quizQuestions,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        drawer: const EndDrawers(),
      ),
    );
  }
}

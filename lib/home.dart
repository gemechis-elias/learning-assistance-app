import 'dart:async';
import 'package:flutter/material.dart';
import 'enddrawer.dart';
import 'teachers/dashboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
          title: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: const Text(
                "Learning Assistant",
                style: TextStyle(
                  fontFamily: 'Urbanist-Bold',
                  fontSize: 23,
                ),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),

              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Text(
                    'Services',
                    style: TextStyle(
                      fontFamily: 'Urbanist-Bold',
                      color: Color.fromARGB(215, 7, 39, 15),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Card 1
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(), //
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(190, 196, 202, 0.2),
                          blurRadius: 14,
                          offset: Offset(0, 9),
                        ),
                      ],
                    ),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      margin: const EdgeInsets.all(0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            child: Image.asset(data_list[0]['image']),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                // textAlign: TextAlign.left,
                                data_list[0]['title'].toUpperCase(),
                                maxLines: 4,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Urbanist-Regular"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card 2
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const BusQueue(), //
                    //   ),
                    // );
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(190, 196, 202, 0.2),
                          blurRadius: 14,
                          offset: Offset(0, 9),
                        ),
                      ],
                    ),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      margin: const EdgeInsets.all(0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            child: Image.asset(data_list[1]['image']),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                // textAlign: TextAlign.left,
                                data_list[1]['title'].toUpperCase(),
                                maxLines: 4,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Urbanist-Regular"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ), // Card 2
            ],
          ),
        ),
        drawer: const EndDrawers(),
      ),
    );
  }
}

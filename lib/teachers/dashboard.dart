import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers Dashboard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () async {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const BuyTicket(), //
                //   ),
                // );
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
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
                          child: Column(
                            children: [
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child:
                                    Image.asset("assets/images/attendance.jpg"),
                              ),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Attendance",
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: "Urbanist-Regular"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 150,
                        height: 150,
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
                          child: Column(
                            children: [
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: Image.asset("assets/images/quiz.jpg"),
                              ),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Create Quiz",
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: "Urbanist-Regular"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Card 2
        ],
      ),
    );
  }
}

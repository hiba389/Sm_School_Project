import 'package:flutter/material.dart';
import 'package:school_app/constant/Responsivness.dart';

import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Column(
          children: [
            Text(
              "Academic Calendar",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenResponse.height(context) * .02),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ScreenResponse.height(context) * .02,
            ),
            TableCalendar(
              rowHeight: ScreenResponse.height(context) * .05,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: ScreenResponse.height(context) * .05),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenResponse.width(context) * .03),
                        child: CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: ScreenResponse.width(context) * .08,
                          child: Column(
                            children: [
                              Text(
                                "05",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .03,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Feb',
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .018,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenResponse.width(context) * .03,
                            left: ScreenResponse.width(context) * .03),
                        child: Container(
                          height: ScreenResponse.height(context) * .08,
                          width: ScreenResponse.width(context) * .7,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 240, 208, 226)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " Kashmir Day",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Holiday',
                                style: TextStyle(
                                  fontSize:
                                      ScreenResponse.height(context) * .018,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenResponse.height(context) * .018,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenResponse.width(context) * .03),
                        child: CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: ScreenResponse.width(context) * .08,
                          child: Column(
                            children: [
                              Text(
                                "23",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .03,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'March',
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .018,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenResponse.width(context) * .03,
                            left: ScreenResponse.width(context) * .03),
                        child: Container(
                          height: ScreenResponse.height(context) * .08,
                          width: ScreenResponse.width(context) * .7,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 224, 228, 232)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                " Pakistan Resolution Day",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Event',
                                style: TextStyle(
                                  fontSize:
                                      ScreenResponse.height(context) * .018,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenResponse.height(context) * .018,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenResponse.width(context) * .03),
                        child: CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: ScreenResponse.width(context) * .08,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "01",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .03,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'May',
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .018,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenResponse.width(context) * .03,
                            left: ScreenResponse.width(context) * .03),
                        child: Container(
                          height: ScreenResponse.height(context) * .08,
                          width: ScreenResponse.width(context) * .7,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 182, 254, 185)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                " Labour Day",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Event',
                                style: TextStyle(
                                  fontSize:
                                      ScreenResponse.height(context) * .018,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenResponse.height(context) * .018,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenResponse.width(context) * .03),
                        child: CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: ScreenResponse.width(context) * .08,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "14",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .03,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Aug',
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .018,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenResponse.width(context) * .03,
                            left: ScreenResponse.width(context) * .03),
                        child: Container(
                          height: ScreenResponse.height(context) * .08,
                          width: ScreenResponse.width(context) * .7,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 250, 221, 221)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " Independence Day",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Event',
                                style: TextStyle(
                                  fontSize:
                                      ScreenResponse.height(context) * .018,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenResponse.height(context) * .018,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenResponse.width(context) * .03),
                        child: CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: ScreenResponse.width(context) * .08,
                          child: Column(
                            children: [
                              Text(
                                "9",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .03,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Nov',
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .018,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenResponse.width(context) * .03,
                            left: ScreenResponse.width(context) * .03),
                        child: Container(
                          height: ScreenResponse.height(context) * .08,
                          width: ScreenResponse.width(context) * .7,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 178, 207, 231)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " Iqbal Day",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Holiday',
                                style: TextStyle(
                                  fontSize:
                                      ScreenResponse.height(context) * .018,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenResponse.height(context) * .018,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenResponse.width(context) * .03),
                        child: CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: ScreenResponse.width(context) * .08,
                          child: Column(
                            children: [
                              Text(
                                "22",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .03,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Dec',
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .018,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenResponse.width(context) * .03,
                            left: ScreenResponse.width(context) * .03),
                        child: Container(
                          height: ScreenResponse.height(context) * .08,
                          width: ScreenResponse.width(context) * .7,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 242, 212, 227)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " Winter Vacation holidays",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '22 to 31',
                                style: TextStyle(
                                  fontSize:
                                      ScreenResponse.height(context) * .018,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenResponse.height(context) * .018,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenResponse.width(context) * .03),
                        child: CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: ScreenResponse.width(context) * .08,
                          child: Column(
                            children: [
                              Text(
                                "25",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .03,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Dec',
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .018,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenResponse.width(context) * .03,
                            left: ScreenResponse.width(context) * .03),
                        child: Container(
                          height: ScreenResponse.height(context) * .08,
                          width: ScreenResponse.width(context) * .7,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 209, 243, 154)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " Quaid-e-azam Day",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * .02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Event',
                                style: TextStyle(
                                  fontSize:
                                      ScreenResponse.height(context) * .018,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenResponse.height(context) * 0.02)
          ],
        ),
      ),
    );
  }
}

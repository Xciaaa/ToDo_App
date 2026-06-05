import 'package:flutter/material.dart';
import 'package:todo_app/pages/menu.dart';
import 'package:todo_app/widgets/global_app_bar.dart';

class AppCalendar extends StatefulWidget {
  const AppCalendar({super.key});

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: GlobalAppBar(
        title: 'Calendar',
        onMenuPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      endDrawer: const AppDrawer(),
      body: const Center(child: Text('Calendar Page')),
    );
  }
}

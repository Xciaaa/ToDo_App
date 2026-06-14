import 'package:flutter/material.dart';
import 'package:todo_app/pages/menu.dart';
import 'package:todo_app/widgets/global_app_bar.dart';
import 'package:todo_app/widgets/global_bottom_nav.dart';
import 'package:todo_app/widgets/global_fab.dart';

class AppCalendar extends StatefulWidget {
  const AppCalendar({super.key});

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/calendar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: GlobalAppBar(
        title: 'Calendar',
        onMenuPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      endDrawer: const AppDrawer(),
      body: const Center(child: Text('Calendar Page')),
      floatingActionButton: GlobalFab(
        onPressed: () {
          Navigator.pushNamed(context, '/addtodo');
        },
      ),
      bottomNavigationBar: GlobalBottomNav(
        currentIndex: 1,
        onTap: _onNavTap,
      ),
    );
  }
}

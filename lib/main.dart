import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/pages/calendar.dart';
import 'package:todo_app/pages/home.dart';
import 'package:todo_app/pages/addtodo.dart';
import 'package:todo_app/pages/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('mybox');

  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  debugPrint('Logger setup at ${DateTime.now()}');
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint(
      '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}',
    );
    developer.log(
      '${record.loggerName}: ${record.message}',
      name: record.loggerName,
      level: record.level.value,
      time: record.time,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      home: const HomePage(),
      routes: {
        '/calendar': (context) => const AppCalendar(),
        '/home': (context) => const HomePage(),
        '/addtodo': (context) => const AddTodo(),
        '/settings': (context) => const SettingsPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const HomePage());
      },
    );
  }
}

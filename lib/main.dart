import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/pages/home.dart';

void main() {
  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  debugPrint('Logger setup at ${DateTime.now()}');
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
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
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
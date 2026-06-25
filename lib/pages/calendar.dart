import 'package:add_2_calendar/add_2_calendar.dart' as add_2_calendar;
import 'package:device_calendar_plus/device_calendar_plus.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/menu.dart';
import 'package:todo_app/widgets/global_app_bar.dart';
import 'package:todo_app/widgets/global_bottom_nav.dart';

class AppCalendar extends StatefulWidget {
  const AppCalendar({super.key});

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _CalendarEventItem {
  const _CalendarEventItem({required this.title, required this.date});

  final String title;
  final DateTime date;
}

class _AppCalendarState extends State<AppCalendar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Singleton instance instantiation
  final DeviceCalendar _deviceCalendarPlugin = DeviceCalendar.instance;

  final add_2_calendar.Event event = add_2_calendar.Event(
    title: 'Event Title',
    description: 'Event Description',
    location: 'Event Location',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(hours: 1)),
  );

  bool _isLoading = false;
  String? _errorMessage;
  final List<_CalendarEventItem> _events = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCalendarEvents();
    });
  }

  String _getUserFriendlyMessage(Object error) {
    final message = error.toString().toLowerCase();
    if (message.contains('no calendars') || message.contains('synchronized')) {
      return 'No calendar account is available on this device. Please add or sync a calendar account, such as Google Calendar, and try again.';
    }
    if (message.contains('permission')) {
      return 'Calendar permission is required to display your synced events.';
    }
    return 'Failed to add event: $error';
  }

  Future<void> _loadCalendarEvents() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // 1. Direct permission checking
      CalendarPermissionStatus status = await _deviceCalendarPlugin.hasPermissions();

      if (status != CalendarPermissionStatus.granted) {
        status = await _deviceCalendarPlugin.requestPermissions();
      }

      if (status != CalendarPermissionStatus.granted) {
        throw Exception('Calendar permission denied');
      }

      // 2. Direct native list retrieval 
      final List<Calendar> calendars = await _deviceCalendarPlugin.listCalendars();

      if (calendars.isEmpty) {
        setState(() {
          _events.clear();
          _isLoading = false;
        });
        return;
      }

      final startDate = DateTime.now().subtract(const Duration(days: 30));
      final endDate = DateTime.now().add(const Duration(days: 365));

      final calendarIds = calendars.map((c) => c.id).whereType<String>().toList();

      // 3. Positional query execution
      final List<Event> rawEvents = await _deviceCalendarPlugin.listEvents(
        startDate,
        endDate,
        calendarIds: calendarIds,
      );

      // FIXED: Swapped event.start to event.startDate
      final List<_CalendarEventItem> loadedEvents = rawEvents
          .map(
            (event) => _CalendarEventItem(
              title: event.title,
              date: event.startDate, 
            ),
          )
          .toList();

      loadedEvents.sort((a, b) => a.date.compareTo(b.date));

      if (!mounted) return;
      setState(() {
        _events
          ..clear()
          ..addAll(loadedEvents);
        _isLoading = false;
      });
    } on DeviceCalendarException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = _getUserFriendlyMessage(e);
        _events.clear();
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = _getUserFriendlyMessage(e);
        _events.clear();
        _isLoading = false;
      });
    }
  }

  Future<void> _addEventToCalendar() async {
    try {
      await add_2_calendar.Add2Calendar.addEvent2Cal(event);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event added to calendar')),
      );
      await _loadCalendarEvents();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_getUserFriendlyMessage(e))),
      );
    }
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              SizedBox(
                height: 360,
                child: Card(
                  color: const Color.fromARGB(200, 221, 166, 184),
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2035),
                    onDateChanged: (date) {
                      debugPrint('Selected date: $date');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Events from your calendars',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: _loadCalendarEvents,
                    child: const Text(
                      'Refresh events',
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 220,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                        ? Center(
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : _events.isEmpty
                            ? const Center(
                                child: Text(
                                  'No calendar events found yet.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _events.length,
                                itemBuilder: (context, index) {
                                  final eventItem = _events[index];
                                  return Card(
                                    color: const Color.fromARGB(200, 221, 166, 184),
                                    child: ListTile(
                                      title: Text(
                                        eventItem.title,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        '${eventItem.date.day}/${eventItem.date.month}/${eventItem.date.year} ${eventItem.date.hour.toString().padLeft(2, '0')}:${eventItem.date.minute.toString().padLeft(2, '0')}',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: _addEventToCalendar,
                child: const Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GlobalBottomNav(
        currentIndex: 1,
        onTap: _onNavTap,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentBookingPage extends StatefulWidget {
  const AppointmentBookingPage({super.key});

  @override
  State<AppointmentBookingPage> createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<Map<String, String>> _appointments = [
    {'title': 'Vet Visit - Bella', 'date': '2025-08-10', 'time': '10:30 AM'},
    {'title': 'Grooming - Bella', 'date': '2025-08-20', 'time': '2:00 PM'},
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_selectedDay == null ||
        _titleController.text.isEmpty ||
        _timeController.text.isEmpty)
      return;

    setState(() {
      _appointments.add({
        'title': _titleController.text,
        'date': _selectedDay!.toIso8601String().split('T')[0],
        'time': _timeController.text,
      });
    });

    _titleController.clear();
    _timeController.clear();
    Navigator.pop(context);
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Add Appointment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            ElevatedButton(onPressed: _addItem, child: const Text('Add')),
          ],
        );
      },
    );
  }

  void _editItem(int index) {
    final item = _appointments[index];
    _titleController.text = item['title']!;
    _timeController.text = item['time']!;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Edit Appointment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _appointments[index] = {
                    'title': _titleController.text,
                    'date': item['date']!,
                    'time': _timeController.text,
                  };
                });
                _titleController.clear();
                _timeController.clear();
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    setState(() {
      _appointments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = _selectedDay?.toIso8601String().split('T')[0];
    final filtered =
        selectedDate == null
            ? _appointments
            : _appointments.where((a) => a['date'] == selectedDate).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Booking'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final appt = filtered[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(appt['title']!),
                    subtitle: Text(
                      'Date: ${appt['date']}\nTime: ${appt['time']}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editItem(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
